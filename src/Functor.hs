module Functor () where

-- everything but the last part of a data declaration is part of the constructor definition
data Tuple a b = Tuple a b deriving (Eq, Show)

instance Functor (Tuple a) where
  fmap f (Tuple a b) = Tuple a (f b)

data BoolAndSomethingElse a = False' a | True' a deriving (Eq, Show)

instance Functor BoolAndSomethingElse where
  fmap f (False' a) = False' (f a)
  fmap f (True' a) = True' (f a)

data BoolAndMaybeSomethingElse a = Falsish | Truish a deriving (Eq, Show)

instance Functor BoolAndMaybeSomethingElse where
  fmap _ Falsish = Falsish
  fmap f (Truish a) = Truish (f a)

data Sum a b = First a | Second b deriving (Eq, Show)

instance Functor (Sum a) where
  fmap _ (First a) = First a
  fmap f (Second b) = Second (f b)
  
data Company a b c = DeepBlue a c | Something b deriving (Eq, Show)

instance Functor (Company a b) where
  fmap f (DeepBlue a c) = DeepBlue a (f c)
  fmap _ (Something b) = Something b