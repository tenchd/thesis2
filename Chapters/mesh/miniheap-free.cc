%\begin{minted}[frame=single,fontsize=\small]{c++}
\begin{minted}[bgcolor=bg,fontsize=\small]{c++}
void ShuffleVector::free(void *ptr) {
  const auto freedOff = getOff(ptr);
  _list[--_off] = freedOff;
  // place newly freed address
  // randomly in the shuffle vector
  auto swapOff =
    _rng.inRange(_off, maxCount() - 1);
  swap(_list[_off], _list[swapOff]);
}
\end{minted}
