%\begin{minted}[frame=single,fontsize=\small]{c++}
\begin{minted}[bgcolor=bg,fontsize=\small]{c++}
void MeshLocal::free(void *ptr) {
  // check if in attached MiniHeap
  for (auto i=0; i<SizeClassCount; i++) {
    const auto curr = _shufVecs[i];
    if (curr->contains(ptr)) {
      curr->free(ptr);
      return; } }
  _global->free(ptr); // general case
}
\end{minted}
