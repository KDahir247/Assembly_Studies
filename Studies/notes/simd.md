# Single Instruction Multiple Data

---
Streaming Simd Extension (SSE) can contain multiple data packed in a XMM register/s.
There are a total of 16 register specifically for SSE instruction. The register are
XMM0 to XMM15.

Each of the XMM register can store 128 bit, so you can store multiple data on each XMM register.

128 bit wide operand can store data in the following way

---

Note :  You can switch int type to a floating point type. You are just required to make sure it is aligned.

two int64 or in some language also called long. (64 bits * 2 lanes == 128 bits) <br/>
SSE instruction happens to all two 64-bit data type (Int64, UInt64, Double) simultaneously.

| Int64 | Int64 |
|-------|-------|
| 63 0  | 63 0  |

four int32 or in some language just called an int. (32 bits * 4 lanes == 128 bits ) <br/>
SSE instruction happens to all four 32-bit data type (Int32, UInt32, Float) simultaneously.

| Int32 | Int32 | Int32 | Int32 |
|-------|-------|-------|-------|
| 31 0  | 31 0  | 31 0  | 31 0  |


eight int16 in some language also called short (16 bits * 8 lanes == 128 bits) <br/>
SSE instruction happens to all eight 16-bit data type (Int16, UInt16) simultaneously.

| Int16 | Int16 | Int16 | Int16 | Int16 | Int16 | Int16 | Int16 |
|-------|-------|-------|-------|-------|-------|-------|-------|
| 15 0  | 15 0  | 15 0  | 15 0  | 15 0  | 15 0  | 15 0  | 15 0  |


sixteen int8 in some language called a sbyte. <br/>
SSE instruction happens to all sixteen 8-bit data type (Byte, SByte) simultaneously.

| Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 | Int8 |
|------|------|------|------|------|------|------|------|------|------|------|------|------|------|------|------|
| 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  | 7 0  |


----

### MXCXR register

SSE also contains on register which is 32-bit register containing flags for control and status information regarding SSE instruction.

| 31 bits  to 16 bits | 15 bit | 14 bit to 13 bit | 12 bit | 11 bit | 10 bit | 9 bit | 8 bit | 7 bit | 6 bit |
|---------------------|--------|------------------|--------|--------|--------|-------|-------|-------|-------|
| reserved            | FZ     | Rcc              | PM     | UM     | OM     | ZM    | DM    | IM    | DAZ   |

| 5 bit | 4 bit | 3 bit | 2 bit | 1 bit | 0 bit |
|-------|-------|-------|-------|-------|-------|
| PE    | UE    | OE    | ZE    | DE    | IE    |



- FZ (15 bit) mode will cause all underflowing operation to go to zero.
- Rcc (14 to 13 bit) modes will determine how the lowest bit is generated <br/>
  (10b == round positive, 01b == round negative, 11b == round to zero, 00b round to nearest).
- 