
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

Existing x86-32 instruction will work on x86-64 (`mov AH, AL ; valid`) <br/>
(`mov AH, R8B ; invalid`)

----

# Commonly used Flags
| Name           | Abbreviation                            |
|----------------|-----------------------------------------|
| Carry Flag     | CF  (1 == Carry, 0 == No Carry)         |
| Parity Flag    | PF  (1 == Parity Even, 0 == Parity Odd) |
| Zero Flag      | ZF  (1 == Zero, 0 == Not Zero)          |
| Sign Flag      | SF  (1 == Negative, 0 == Positive)      |
| Direction Flag | DF  (1 == Down, 0 == Up)                |
| Overflow       | OF  (1 == Overflow, 0 == Not Overflow)  |


There are some arithmetic instruction and logic instruction that modifies the status flags (RFLAG register) <br/>.
Some common condition instruction are cmovcc, jcc, setcc where cc is replace with the Mnemonic suffix.

[cmovcc instructions](https://www.felixcloutier.com/x86/cmovcc)

[setcc instructions](https://www.felixcloutier.com/x86/setcc)

[jcc instructions](https://www.felixcloutier.com/x86/jcc) 

there are more conditional instruction than these 3 provided, but their mnemonic suffix are all the same </br>
Note that some mnemonic suffixes are for signed integer type (e.g. Less and Greater) while other are for unsigned integer type (e.g. Above and Below)   

Conditional instruction can improve readability and improve "performance" (not entirely true may even deteriorate performance) in a sense that is oblivious to branch prediction in some cases.
This will avoid cost of potential branch predication which can cost up to 10 to 20 cycle.

If a branch can is easily predictable use a jmp, which will almost un-likely cause a branch mis-predication which is faster
than a condition move (cmovcc), but if the branch isn't easily predictable then use cmovcc instruction
which will be oblivious of branch predication, but won't go as fast as a correctly predicated branch.  

Overall don't use conditional instruction unless you know your program is causing lots of mis predication

### how it minimizes branch mis predication

1) Join same evaluate condition since condition usually has to satisfy one condition (**Remember keep the one cheap to evaluate before the other expensive to evaluate so the expensive condition doesn't get evaluated needlessly**)<br/>
E.g if `(array[i] > 0) some_function_call();` and `(array[i] == 1) call_function_call();` can be combined <br/>
`if (array[i] > 0 || array[i] == 1) call_some function() // we can remove arr[i] == 1 in this case, since it redundent` which will only evaluate one condition if it results to true this also applies for && which will get rid of one branch. (add complexity)
2) Use a look-up table. (increase memory needed for program)
3) Use compiler condition hints such as Likely and Unlikely to hint higher probability. (hint probability doesn't really remove the probability)
4) Use generic, const generic, template of type bool E.g`if(GenericBool)`. This may bloat your code source and increase to compile time, but will remove the branching, since there will be two identical function created one for false and the other for true. This is good removing condition statement in hot code, but you might still need to use branch do decide on if the generic should be true or false. (increase compile time).   
5) Use clever arithmetic operation and/or bitwise operation (it may be unreadable though)
6) Organize you data and container to prevent branch. [data oriented design principle/s](https://www.dataorienteddesign.com/dodbook/)  looks like it helps solves this to an extent
7) Optimized chain of if/else and reduce it.
8) avoid inner condition/s inside other condition/s

there are many other ways to minimize branch mis  predication or remove it entirely.