module Monads where

import Control.Monad (join)


-- Monads are Applicative Functors with a bind function

-- class Applicative m => Monad m where
--   (>>=) :: m a -> (a -> m b) -> m b
--   (>>) :: m a -> m b -> m bl
--   return :: a -> m a

-- Since Monad is a subclass of Applicative, and Applicative is a subclass of Functor, we can define fmap in terms of >>= and return
-- fmap :: Monad m => (a -> b) -> m a -> m b
-- fmap f xs = xs >>= return . f

fmapWithMonads :: [Integer]
fmapWithMonads = [1,2,3] >>= return . (*2)

-- The bind function is also known as the Kleisli composition operator

andOne :: Num a => a -> [a]
andOne x = [x, 1]

-- This generates more monadic structure than we started with
andOneList :: [[Integer]]
andOneList = fmap andOne [4,5,6]

-- This flattens the monadic structure with concat
andOneList' :: [Integer]
andOneList' = concat $ fmap andOne [4,5,6]

-- fully generalised concat is concat :: Foldable t => t [a] -> [a]
-- so in a sense Monad is a generalisation of concat, which expresses its uniqueness with the join function
-- join :: Monad m => m (m a) -> m a 
-- We can define bind in terms of join and fmap
myOwnBind :: Monad m => (a -> m b) -> m a -> m b
myOwnBind f xs = join $ fmap f xs -- (f <<= xs )
