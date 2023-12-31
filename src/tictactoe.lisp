(defun initial-game () nil)

(defun game-status (game)
  (labels ((lines () '((0 1 2) (3 4 5) (6 7 8) (0 3 6) (1 4 7) (2 5 8) (0 4 8) (6 4 2)))
           (has-cellp (cell player game)
                        (equalp (cons cell player) (assoc cell game :test #'equalp)))
           (has-linep (line player game)
                        (every (lambda (cell) (has-cellp cell player game)) line))
           (win-p (player game)
                    (some (lambda (line) (has-linep line player game)) (lines))))
    (cond 
      ((win-p 'x game) 'x-win)
      ((win-p 'o game) 'o-win)
      ((= 9 (length game)) 'draw)
      ((evenp (length game)) 'x-to-play)
      (t 'o-to-play))))

(defun move (game row col)
  (labels ((player (game)
                   (if (eql 'x-to-play (game-status game)) 'x 'o))
           (coord (col row)
                  (+ (1- col) (* 3 (1- row)))))
    (let ((p (player game))
          (m (coord row col)))
      (if (assoc m game :test #'equal)
        game
        (cons (cons m p) game)))))
