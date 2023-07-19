module Applicative 
  (addToList)  
  where

import Control.Applicative

-- Applicatives can be thought of as monoidal functors, or functors with some added structure.
-- fmap :: Functor f => (a -> b) -> f a -> f b
-- (<*>) :: Applicative f => f (a -> b) -> f a -> f b
-- fmap f x =  pure f <*> x

addToList :: [Integer]
addToList = fmap (+1) [1,2,3]

addToListApplicative :: [Integer]
addToListApplicative = pure (+1) <*> [1,2,3]

withLiftA :: [Integer]
withLiftA = liftA (+1) [1,2,3]

-- Applicatives are Monoids because they have a function that combines two values of one type into one of the same type.
applicativeMaybe :: Maybe Integer
applicativeMaybe = Just (*2) <*> Just 3

applicativeMaybeString :: Maybe String
applicativeMaybeString = Just ("Whoo" <>) <*> Just " Hoo!"

-- (<*>) :: Applicative f => f (a -> b) -> f a -> f b
-- This is the same as the above, but with the Applicative instance for Maybe.
applicativeMaybeWithParams :: Maybe (a -> b) -> Maybe a -> Maybe b
applicativeMaybeWithParams x y = x <*> y

-- it can also be thought as
applicativeListfmap :: [Integer]
applicativeListfmap = (+) <$> [1,2,3] <*> [4,5,6]

-- the same can be done with liftA2, which lifts a function into an applicative context
theSameWithLiftA2 :: [Integer]
theSameWithLiftA2 = liftA2 (+) [1,2,3] [4,5,6]

liftA2WithTuples :: [(Integer, Integer)]
liftA2WithTuples = liftA2 (,) [1,2,3] [4,5,6]

