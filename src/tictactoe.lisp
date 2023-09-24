(defun initial-game () nil)

(defun game-status (game)
  (if (evenp (length game))
    'x-to-play
    'o-to-play))

(defun move (game row col)
  (labels ((player (game)
                   (if (eql 'x-to-play (game-status game))
                     'x
                     'o)))
    (let ((p (player game))
          (m (cons row col)))
      (if (assoc m game :test #'equal)
        game
        (cons (cons m p) game)))))
