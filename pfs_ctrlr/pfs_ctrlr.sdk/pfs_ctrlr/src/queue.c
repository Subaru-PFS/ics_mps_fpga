/**
 * \file
 * \author Joshua Schoolcraft <jschoolc@jpl.nasa.gov>
 * \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
 * \brief
 *
 * \copyright
 * Copyright 2009-2014, by the California Institute of Technology.
 * ALL RIGHTS RESERVED.  United States Government Sponsorship
 * acknowledged. Any commercial use must be negotiated with the Office
 * of Technology Transfer at the California Institute of Technology.
 * \copyright
 * This software may be subject to U.S. export control laws and
 * regulations.  By accepting this document, the user agrees to comply
 * with all U.S. export laws and regulations.  User has the
 * responsibility to obtain export licenses, or other export authority
 * as may be required before exporting such information to foreign
 * countries or providing access to foreign persons.
 ********************************************************************/

#include "queue.h"

int q_alloc_(queue_ *queue, unsigned int depth, unsigned int size) {
    queue->data = malloc(depth*size);
    if (NULL == queue->data) {
        return -1;
    }

    queue->end = queue->data + size*depth;
    queue->wr = queue->data;
    queue->rd = queue->data;

    return 0;
}

void q_free_(queue_ *queue) {
    free(queue->data);
    queue->data = NULL;
    queue->end = NULL;
    queue->rd = NULL;
    queue->wr = NULL;
}

int q_enq_(queue_ *queue, const unsigned char *obj, unsigned int size) {
    memcpy(queue->wr, obj, size);

    queue->wr += size;
    if (queue->wr >= queue->end) {
        queue->wr = queue->data;
    }

    return 0;
}

int q_deq_(queue_ *queue, unsigned char *obj, unsigned int size) {
    if (queue->wr == queue->rd) {
        return 0;
    }

    memcpy(obj, queue->rd, size);

    queue->rd += size;
    if (queue->rd >= queue->end) {
        queue->rd = queue->data;
    }

    return 1;
}

int q_enq_n_(queue_ *queue, const unsigned char *obj, unsigned int n, unsigned int size) {
    unsigned int to_copy;

    if (n == 0) {
        return 0;
    }

    n = MIN(n, (queue->end - queue->data)/size);

    to_copy = (queue->end - queue->wr)/size;
    to_copy = MIN(to_copy, n);

    memcpy(queue->wr, obj, to_copy*size);

    queue->wr += to_copy*size;
    if (queue->wr >= queue->end) {
        queue->wr = queue->data;
    }

    /* Normally recursion is bad.  But the n = MIN()... and */
    /* n == 0 -> return above ensures at most 3 nested calls. */
    return to_copy + q_enq_n_(queue, obj + size*to_copy, n - to_copy, size);
}

int q_deq_n_(queue_ *queue, unsigned char *obj, unsigned int n, unsigned int size) {
    unsigned int to_copy;

    if (n == 0) {
        return 0;
    }

    if (queue->wr == queue->rd) {
        return 0;
    }

    n = MIN(n, (queue->end - queue->data)/size);

    if (queue->rd > queue->wr) {
        to_copy = (queue->end - queue->rd)/size;
    } else {
        to_copy = (queue->wr - queue->rd)/size;
    }
    to_copy = MIN(to_copy, n);

    memcpy(obj, queue->rd, to_copy*size);

    queue->rd += to_copy*size;
    if (queue->rd >= queue->end) {
        queue->rd = queue->data;
    }

    return to_copy + q_deq_n_(queue, obj + size*to_copy, n - to_copy, size);
}

int q_util_(queue_ *queue, unsigned int size) {
    if (queue->rd <= queue->wr) {
        return (queue->wr - queue->rd)/size;
    }
    return ((queue->end - queue->rd) + (queue->wr - queue->data))/size;
}

