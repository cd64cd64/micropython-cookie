/*
    GNU linker script for STM32F412
*/

/* Specify the memory areas */
MEMORY
{
    FLASH (rx)      : ORIGIN = 0x08010000, LENGTH = 512K-48k /* entire flash 0,1,2,bl*/
    FLASH_ISR (rx)  : ORIGIN = 0x08010000, LENGTH = 16K /* sector 3 */
    FLASH_FS (rx)   : ORIGIN = 0x08014000, LENGTH = 64K /* sectors 4: 64k */
    FLASH_TEXT (rx) : ORIGIN = 0x08024000, LENGTH = 384K /* sectors 5,6,7 are 128K */
    RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 240K
    FS_CACHE (xrw)  : ORIGIN = 0x2003c000, LENGTH = 16K
}

/* produce a link error if there is not this amount of RAM for these sections */
_minimum_stack_size = 2K;
_minimum_heap_size = 16K;

/* Define the stack.  The stack is full descending so begins just above last byte
   of RAM.  Note that EABI requires the stack to be 8-byte aligned for a call. */
_estack = ORIGIN(RAM) + LENGTH(RAM) - _estack_reserve;
_sstack = _estack - 16K; /* tunable */

/* RAM extents for the garbage collector */
_ram_start = ORIGIN(RAM);
_ram_end = ORIGIN(RAM) + LENGTH(RAM);
_heap_start = _ebss; /* heap starts just after statically allocated memory */
_heap_end = _sstack;

/* Filesystem cache in RAM, and storage in flash */
_micropy_hw_internal_flash_storage_ram_cache_start = ORIGIN(FS_CACHE);
_micropy_hw_internal_flash_storage_ram_cache_end = ORIGIN(FS_CACHE) + LENGTH(FS_CACHE);
_micropy_hw_internal_flash_storage_start = ORIGIN(FLASH_FS);
_micropy_hw_internal_flash_storage_end = ORIGIN(FLASH_FS) + LENGTH(FLASH_FS);
