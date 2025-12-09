
Advanced Calculator v2.0 (8086 Assembly)

A fully interactive **Advanced Calculator written in 8086 Assembly Language** supporting **signed numbers (+ and –)**, UI layout, error messages, and mathematical operations.
Runs in DOS / emu8086 and uses Interrupt 21H for I/O.

---

Features

✔ Addition
✔ Subtraction
✔ Multiplication
✔ Division
✔ Signed input handling (+ or –)
✔ Division-by-zero prevention
✔ Attractive ASCII UI
✔ Custom result formatting
✔ Modular procedures

---

Technology Used

| Component    | Description           |
| ------------ | --------------------- |
| Language     | 8086 Assembly         |
| Tools        | Emu8086 / MASM / TASM |
| I/O          | INT 21H               |
| Architecture | .MODEL SMALL          |

---

Operations Supported

| Operation   | Symbol |
| ----------- | ------ |
| Addition    | `+`    |
| Subtraction | `-`    |
| Multiply    | `×`    |
| Division    | `÷`    |

---

Input Format

You can enter:

```
12
-8
+20
```

Signed values are handled manually without built-in functions.

---

⚠ Error Handling

Error cases handled internally:

* Invalid menu option
* Division by zero
* Blank input
* Wrong key entry

---

## 📂 Project Structure

```
/Advanced-Calculator
│
├── main.asm
├── screenshots/
└── README.md
```

---

How To Run

### With Emu8086

1. Open project in Emu8086
2. Press Compile
3. Press Run

With DOSBox

```
masm main.asm
link main.obj
main.exe
```

---

Screenshots

(You may attach during GitHub upload)

---

How It Works (Short Explanation)

* Menu selection stored in register BH
* Two numbers read using manual signed parser
* Arithmetic performed with ADD, SUB, IMUL, IDIV
* Result printed using custom number-to-ASCII conversion

---

Code Concepts Used

* Procedures
* Stack operations
* Signed arithmetic
* ASCII conversion
* Interrupt-based input/output
* UI using string DB arrays







Just tell me and I’ll make it ✨
