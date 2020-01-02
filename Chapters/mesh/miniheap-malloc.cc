%\begin{minted}[frame=single,fontsize=\small]{c++}
\begin{minted}[bgcolor=bg,fontsize=\small]{c++}
void *ShuffleVector::malloc() {
  const auto off = _list[_off++];
  return _spanStart + off * _objSize;
}
\end{minted}
