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

    (test after-playing-to-a-square-already-played-game-is-unchanged
     (let* ((game-1 (move (initial-game) 1 1))
            (game-2 (move game-1 1 1)))
      (is (equal game-1 game-2))))
(run!)

