module Paths_test_textmewhen_haskell (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/user/personal_projects/test_textmewhen_haskell/.cabal-sandbox/bin"
libdir     = "/home/user/personal_projects/test_textmewhen_haskell/.cabal-sandbox/lib/x86_64-linux-ghc-7.6.3/test-textmewhen-haskell-0.1.0.0"
datadir    = "/home/user/personal_projects/test_textmewhen_haskell/.cabal-sandbox/share/x86_64-linux-ghc-7.6.3/test-textmewhen-haskell-0.1.0.0"
libexecdir = "/home/user/personal_projects/test_textmewhen_haskell/.cabal-sandbox/libexec"
sysconfdir = "/home/user/personal_projects/test_textmewhen_haskell/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "test_textmewhen_haskell_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "test_textmewhen_haskell_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "test_textmewhen_haskell_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "test_textmewhen_haskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "test_textmewhen_haskell_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
