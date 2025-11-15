; ФУНКЦІОНАЛЬНИЙ ПІДХІД
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
;набір для тестування
(defun check-selection-sort (name input expected) 
  "Execute `selection-sort' on `input', compare result with `expected' and print comparison status"
  (format t "~:[FAILED~;passed~]... ~a~%" (equal (selection-sort input) expected) name))

(defun test-selection-sort ()
  (check-selection-sort "test-1" '(3 5 2 6 1 8 4 7) '(1 2 3 4 5 6 7 8))
  (check-selection-sort "test-2" '(6 5 4 3 2 1) '(1 2 3 4 5 6))
  (check-selection-sort "test-3" '(1 2 3 4 5 6) '(1 2 3 4 5 6))
  (check-selection-sort "test-4" '() '()))
