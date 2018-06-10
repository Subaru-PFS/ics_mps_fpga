################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/pfs.c \
../src/pfs_eth.c \
../src/pfs_queues.c \
../src/pfs_translate.c \
../src/platform.c \
../src/platform_mb.c \
../src/project.c \
../src/queue.c 

OBJS += \
./src/pfs.o \
./src/pfs_eth.o \
./src/pfs_queues.o \
./src/pfs_translate.o \
./src/platform.o \
./src/platform_mb.o \
./src/project.o \
./src/queue.o 

C_DEPS += \
./src/pfs.d \
./src/pfs_eth.d \
./src/pfs_queues.d \
./src/pfs_translate.d \
./src/platform.d \
./src/platform_mb.d \
./src/project.d \
./src/queue.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../eth_bsp/microblaze_0/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v10.0 -mno-xl-soft-mul -mxl-multiply-high -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


