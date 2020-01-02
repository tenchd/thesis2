% \begin{minted}[frame=single,fontsize=\small]{c++}
\begin{minted}[bgcolor=bg,fontsize=\small]{c++}
void ShuffleVector::attach(MiniHeap *mh) {
  _mh = mh;
  _off = maxCount();
  for (auto i = 0; i < maxCount(); i++) {
    // true if atomically set from 0 -> 1
    if (bitmap.tryToSet(i)) {
      _list[_off--] = i; } }
  shuffle(_list[_off], _list[maxCount()]);
}
\end{minted}
