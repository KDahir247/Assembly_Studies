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

