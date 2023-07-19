module Monads (tuplesWithLiftM2) where

import Control.Monad (join, liftM, liftM2, liftM3)


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

andOneList'' :: [Integer]
andOneList'' = join $ fmap andOne [4,5,6]

-- We can define bind in terms of join and fmap
myOwnBind :: Monad m => (a -> m b) -> m a -> m b
myOwnBind f xs = join $ fmap f xs -- (f <<= xs )

-- bind is used to compose monadic functions
doSomethingToMaybe :: Maybe Integer -> Maybe Integer
doSomethingToMaybe mx = mx >>= (\x -> Just (x + 1))

-- The above is equivalent to
doSomethingToMaybe' :: Maybe Integer -> Maybe Integer
doSomethingToMaybe' mx = do
  x <- mx
  return (x + 1)
  
-- Monads have their own set of lift functions, liftM, liftM2, liftM3.
-- liftM is fmap with different typeclass constraints

-- liftM :: Monad m => (a -> b) -> m a -> m b
-- liftM f xs = xs >>= return . f
doubleMonadsWithLift :: (Monad m, Num a) =>  m a -> m a
doubleMonadsWithLift = liftM (*2)

-- liftM2 lets us lift a function of two arguments into a monad
tuplesWithLiftM2 :: [(Integer, Integer)]
tuplesWithLiftM2 = liftM2 (,) [1,2] [3,4]