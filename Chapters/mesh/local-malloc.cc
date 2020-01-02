%\begin{minted}[bgcolor=bg,fontsize=\small]{c++}
\definecolor{bg}{rgb}{0.95,0.95,0.95}
\begin{minted}[bgcolor=bg,fontsize=\small]{c++}
void *MeshLocal::malloc(size_t sz) {
  int szClass;
  // forward to global heap if large
  if (!getSizeClass(sz, &szClass))
    return _global->malloc(sz);
  auto shufVec = _shufVecs[szClass];
  if (shufVec.isExhausted()) {
    shufVec.detachMiniheap();
    shufVec.attach(
      _global->allocMiniheap(szClass));}
  return shufVec.malloc();
}
\end{minted}
