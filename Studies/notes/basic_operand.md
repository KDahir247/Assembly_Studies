
# Operand type

_Small table to distinguish the difference_

| Immediate Type           | Register Type               | Memory Type                                          |
|--------------------------|-----------------------------|------------------------------------------------------|
| `mov RCX, 20` (RCX = 20) | `mov RAX, R10` (RAX = R10)  | `mov RAX,  [RSI + RCX * 8]` (RAX = *(RSI + RCX * 8)) | 
| `add RCX, 1`  (RCX +=1)  | `add RAX, RCX` (RAX += RCX) | `add RAX, [RSP]`  (RAX += *RSP)                      |


-------------

# Registers

| 8 bit size    | 16 bit size   | 32 bit size    | 64 bit size    |
|---------------|---------------|----------------|----------------|
| `sub AL, CL`  | `sub AX, CX`  | `sub EAX, ECX` | `sub RAX, RCX` |
| `add BL, R8B` | `add BX, R8W` | `add EBX, R8D` | `add RBX, R8 ` |


##### **Notes**

-----
x86-64 platform restrict legacy registers. They can not be used with instruction that also reference the newer 8 bit register <br/>
These are;
- SIL (RSI 8 bit lower)
- BPL (RBP 8 bit lower)
- DIL (RDI 8 bit lower)
- SPL (RSP 8 bit lower)
- R8B to R15B

