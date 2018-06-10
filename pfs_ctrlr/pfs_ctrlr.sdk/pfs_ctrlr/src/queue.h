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

#ifndef QUEUE_H_
#define QUEUE_H_

#include <stdlib.h>
#include <string.h>

/// Macro to return minimum
#define MIN(x,y) ((x) < (y) ? (x) : (y))

/// Define a structured queue type name
#define QUEUE(type) type ## _q_t

/// Macros defining structured function names
#define ALLOC_(type) type ## _q_alloc
#define FREE_(type)  type ## _q_free
#define ENQ_(type)   type ## _q_enq
#define DEQ_(type)   type ## _q_deq
#define ENQ_N_(type) type ## _q_enq_n
#define DEQ_N_(type) type ## _q_deq_n
#define UTIL_(type)  type ## _q_util


#define DECL_TYPED_QUEUE(type, tname)                                           \
                                                                                \
struct tname;                                                                   \
                                                                                \
typedef struct tname {                                                          \
    type *data;                                                                 \
    type *end;                                                                  \
    type *wr;                                                                   \
    type *rd;                                                                   \
    int  (*alloc)(struct tname *queue, unsigned int depth);               \
    void (*free)(struct tname *queue);                                    \
    int  (*enq)(struct tname *queue, const type *obj);                    \
    int  (*deq)(struct tname *queue, type *obj);                          \
    int  (*enq_n)(struct tname *queue, const type *obj, unsigned int n);  \
    int  (*deq_n)(struct tname *queue, type *obj, unsigned int n);        \
    int  (*util)(struct tname *queue);                                    \
} tname

DECL_TYPED_QUEUE(unsigned char, queue_);

#define CREATE_QUEUE(type, var)         \
    QUEUE(type) var = {                 \
        .data = NULL,                   \
        .end = NULL,                    \
        .wr = NULL,                     \
        .rd = NULL,                     \
        .alloc = ALLOC_(type),          \
        .free = FREE_(type),            \
        .enq = ENQ_(type),              \
        .deq = DEQ_(type),              \
        .enq_n = ENQ_N_(type),          \
        .deq_n = DEQ_N_(type),          \
        .util = UTIL_(type)             \
    }

#define DECL_QUEUE(type)                                                    \
    DECL_TYPED_QUEUE(type, QUEUE(type));                                    \
                                                                            \
    int  ALLOC_(type) (QUEUE(type) *queue, unsigned int depth);              \
    void FREE_(type) (QUEUE(type) *queue);                                   \
    int  ENQ_(type) (QUEUE(type) *queue, const type *obj);                   \
    int  DEQ_(type) (QUEUE(type) *queue, type *obj);                         \
    int  ENQ_N_(type) (QUEUE(type) *queue, const type *obj, unsigned int n); \
    int  DEQ_N_(type) (QUEUE(type) *queue, type *obj, unsigned int n);       \
    int  UTIL_(type) (QUEUE(type) *queue)

#define DEFN_QUEUE(type)                                                                \
    int  ALLOC_(type) (QUEUE(type) *queue, unsigned int depth) {                         \
        return q_alloc_((queue_ *)queue, depth, sizeof(type));                          \
    }                                                                                   \
                                                                                        \
    void FREE_(type) (QUEUE(type) *queue) {                                              \
        q_free_((queue_ *)queue);                                                       \
    }                                                                                   \
                                                                                        \
    int  ENQ_(type) (QUEUE(type) *queue, const type *obj) {                             \
        return q_enq_((queue_ *)queue, (const unsigned char *)obj, sizeof(type));       \
    }                                                                                   \
    int  DEQ_(type) (QUEUE(type) *queue, type *obj) {                                    \
        return q_deq_((queue_ *)queue, (unsigned char *)obj, sizeof(type));             \
    }                                                                                   \
    int  ENQ_N_(type) (QUEUE(type) *queue, const type *obj, unsigned int n) {            \
        return q_enq_n_((queue_ *)queue, (const unsigned char *)obj, n, sizeof(type));  \
    }                                                                                   \
    int  DEQ_N_(type) (QUEUE(type) *queue, type *obj, unsigned int n) {                  \
        return q_deq_n_((queue_ *)queue, (unsigned char *)obj, n, sizeof(type));        \
    }                                                                                   \
    int  UTIL_(type) (QUEUE(type) *queue) {                                              \
        return q_util_((queue_ *)queue, sizeof(type));                                  \
    }

int  q_alloc_(queue_ *queue, unsigned int depth, unsigned int size);
void q_free_(queue_ *queue);
int  q_enq_(queue_ *queue, const unsigned char *obj, unsigned int size);
int  q_deq_(queue_ *queue, unsigned char *obj, unsigned int size);
int  q_enq_n_(queue_ *queue, const unsigned char *obj, unsigned int n, unsigned int size);
int  q_deq_n_(queue_ *queue, unsigned char *obj, unsigned int n, unsigned int size);
int  q_util_(queue_ *queue, unsigned int size);

#endif /* QUEUE_H_ */
