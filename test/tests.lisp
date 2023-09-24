(ql:quickload "fiveam")
(in-package :fiveam)
(def-suite* tictactoe-status)

(load "./src/tictactoe.lisp")

(test initially-status-is-x-to-play
      (is (eql 'x-to-play
               (game-status (initial-game)))))

(test after-one-move-status-is-o-to-play
      (let ((game (move (initial-game) 1 1)))
        (is (eql 'o-to-play (game-status game)))))

(test after-two-moves-status-is-x-to-play
      (let ((game (move (move (initial-game) 1 1) 2 1)))
        (is (eql 'x-to-play (game-status game)))))

(test after-playing-on-a-square-already-played-game-is-unchanged
      (let* ((game-1 (move (initial-game) 1 1))
             (game-2 (move game-1 1 1)))
        (is (equal game-1 game-2))))

(test after-x-makes-a-line-the-game-is-won-by-x
      (let ((game (reduce 
                    (lambda (g coords)
                        (move g (car coords) (cadr coords)))
                    '((1 1) (2 1) (1 2) (2 2) (1 3)) 
                    :initial-value (initial-game))))
        (is (eql 'x-win (game-status game)))))

(test after-o-makes-a-line-the-game-is-won-by-o
      (let ((game (reduce 
                    (lambda (g coords)
                        (move g (car coords) (cadr coords)))
                    '((1 1) (3 1) (1 2) (2 2) (3 3) (1 3))
                    :initial-value (initial-game))))
        (is (eql 'o-win (game-status game)))))

(test after-nine-moves-without-line-it-is-a-draw
      (let ((game (reduce 
                    (lambda (g coords)
                        (move g (car coords) (cadr coords)))
                    '((2 1) (1 1) (2 2) (1 2) (3 2) (3 1) (1 3) (2 3) (3 3))
                    :initial-value (initial-game))))
        (is (eql 'draw (game-status game)))))
(run!)

