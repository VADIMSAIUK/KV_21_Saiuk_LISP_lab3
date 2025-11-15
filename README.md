<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/> 
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right">
    <strong>Студент</strong>: <em><strong>Саюк Вадим Анатолійович</strong></em>
</p>
<p align="right">
    <strong>Група</strong>: <em><strong>КВ-21</strong></em>
</p>
<p align="right">
    <strong>Рік</strong>: <em><strong>2025</strong></em>
</p>

## Загальне завдання
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і імперативно.
1. *Функціональний* варіант реалізації має базуватись на використанні рекурсії і конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку. Не допускається використання: псевдо-функцій, деструктивних операцій, циклів, функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. *Імперативний* варіант реалізації має базуватись на використанні циклів і деструктивних функцій (псевдофункцій). Не допускається використання функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Тим не менш, оригінальний список цей варіант реалізації також не має змінювати, тому перед виконанням деструктивних змін варто застосувати функцію copy-list (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).

## Варіант 16 (1 за модулем 5)
Алгоритм сортування вибором за незменшенням.

## Лістинг функції з використанням конструктивного підходу
```lisp

(defun find-min (lst)
  "Знаходить мінімальний елемент у списку"
  (if (null (cdr lst))
      (car lst)
      (let ((min-rest (find-min (cdr lst))))
        (if (< (car lst) min-rest)
            (car lst)
            min-rest))))

(defun remove-first (element lst)
  "Видаляє перше входження елемента зі списку"
  (cond ((null lst) nil)
        ((= element (car lst)) (cdr lst))
        (t (cons (car lst) (remove-first element (cdr lst))))))

(defun selection-sort (lst)
  "Головна функція сортування вибором (функціональний підхід)"
  (if (null lst)
      nil
      (let ((min-element (find-min lst)))
        (cons min-element 
              (selection-sort (remove-first min-element lst))))))
```

### Тестові набори та утиліти
```lisp
(defun check-selection-sort (name input expected) 
  "Execute `selection-sort' on `input', compare result with `expected' and print comparison status"
  (format t "~:[FAILED~;passed~]... ~a~%" (equal (selection-sort input) expected) name))

(defun test-selection-sort ()
  (check-selection-sort "test-1" '(3 5 2 6 1 8 4 7) '(1 2 3 4 5 6 7 8))
  (check-selection-sort "test-2" '(6 5 4 3 2 1) '(1 2 3 4 5 6))
  (check-selection-sort "test-3" '(1 2 3 4 5 6) '(1 2 3 4 5 6))
  (check-selection-sort "test-4" '() '()))
```

### Тестування
```lisp
CL-USER> (test-selection-sort-cycle)
passed... test-1
passed... test-2
passed... test-3
passed... test-4
NIL
```
--------------------------------------------------------------------------------------------
## Лістинг функції з використанням деструктивного підходу
```lisp
(defun selection-sort-cycle (list)
  "Сортування вибором (імперативний підхід)"
  (when (null list) (return-from selection-sort-cycle nil))
  
  (let ((lst (copy-list list))
        (n (length list)))
    (do ((i 0 (1+ i)))
        ((>= i (- n 1)) lst)
      ; Знаходимо індекс мінімального елемента в несортованій частині
      (let ((min-index i)
            (min-val (nth i lst)))
        ; Шукаємо мінімальний елемент в підсписку
        (do ((j (+ i 1) (1+ j))
             (sublist (nthcdr (+ i 1) lst) (cdr sublist)))
            ((>= j n))
          (when (< (car sublist) min-val)
            (setf min-index j
                  min-val (car sublist))))
        ; Міняємо місцями поточний елемент з мінімальним
        (when (/= i min-index)
          (let ((temp (nth i lst)))
            (setf (nth i lst) (nth min-index lst)
                  (nth min-index lst) temp)))))))
```

### Тестові набори та утиліти
```lisp
(defun check-selection-sort-cycle (name input-lst expected) 
  "Execute `selection-sort-cycle' on `input', compare result with `expected' and print comparison status" 
  (format t "~:[FAILED~;passed~]... ~a~%" 
          (equal (selection-sort-cycle input-lst) expected) 
          name))

(defun test-selection-sort-cycle ()
  (check-selection-sort-cycle "test-1" '(3 5 2 6 1 8 4 7) '(1 2 3 4 5 6 7 8))
  (check-selection-sort-cycle "test-2" '(6 5 4 3 2 1) '(1 2 3 4 5 6))
  (check-selection-sort-cycle "test-3" '(1 2 3 4 5 6) '(1 2 3 4 5 6))
  (check-selection-sort-cycle "test-4" '() '()))
```

### Тестування
```lisp
CL-USER> (test-selection-sort-cycle)
passed... test-1
passed... test-2
passed... test-3
passed... test-4
NIL
```
