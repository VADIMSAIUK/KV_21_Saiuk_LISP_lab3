; ІМПЕРАТИВНИЙ ПІДХІД
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
;набір для тестування
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
