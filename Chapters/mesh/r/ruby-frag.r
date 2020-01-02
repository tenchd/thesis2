library(ggplot2)
library(grid)
library(scales)

dat_mesh2n <- read.delim('../data/ruby-frag-mstat/ruby-frag-mesh2n.1542413574.tsv', header = TRUE, sep = '\t')
dat_mesh2n$alloc <- 'Mesh (no meshing)'
dat_mesh2n$rss <- dat_mesh2n$rss / 1024.0 / 1024.0
dat_mesh2n$time <- dat_mesh2n$time / 1000000000.0

dat_mesh0y <- read.delim('../data/ruby-frag-mstat/ruby-frag-mesh0y.1542413600.tsv', header = TRUE, sep = '\t')
dat_mesh0y$alloc <- 'Mesh (no rand)'
dat_mesh0y$rss <- dat_mesh0y$rss / 1024.0 / 1024.0
dat_mesh0y$time <- dat_mesh0y$time / 1000000000.0

dat_mesh2y <- read.delim('../data/ruby-frag-mstat/ruby-frag-mesh2y.1542413635.tsv', header = TRUE, sep = '\t')
dat_mesh2y$alloc <- 'Mesh'
dat_mesh2y$rss <- dat_mesh2y$rss / 1024.0 / 1024.0
dat_mesh2y$time <- dat_mesh2y$time / 1000000000.0

dat_glibc <- read.delim('../data/ruby-frag-mstat/ruby-frag-libc.1542413616.tsv', header = TRUE, sep = '\t')
dat_glibc$alloc <- 'glibc'
dat_glibc$rss <- dat_glibc$rss / 1024.0 / 1024.0
dat_glibc$time <- dat_glibc$time / 1000000000.0

dat_jemalloc <- read.delim('../data/ruby-frag-mstat/ruby-frag-jemalloc.1542413638.tsv', header = TRUE, sep = '\t')
dat_jemalloc$alloc <- 'jemalloc'
dat_jemalloc$rss <- dat_jemalloc$rss / 1024.0 / 1024.0
dat_jemalloc$time <- dat_jemalloc$time / 1000000000.0

## dat_diehard <- read.delim('../data/redis-lru/redis-lru-diehard.tsv', header = TRUE, sep = '\t')
## dat_diehard$alloc <- 'DieHard'
## dat_diehard$rss <- dat_diehard$rss / 1024.0 / 1024.0
## dat_diehard$time <- dat_diehard$time / 1000000000.0

p <- ggplot() +
    ## geom_line(data=dat_mesh_activedefrag, size=.3, aes(x=time, y=rss, color=alloc, group=1)) +
    geom_line(data=dat_mesh2n, size=.3, aes(x=time, y=rss, color=alloc, group=2)) +
    geom_line(data=dat_mesh0y, size=.3, aes(x=time, y=rss, color=alloc, group=3)) +
    ## geom_line(data=dat_mesh1y, size=.3, aes(x=time, y=rss, color=alloc, group=4)) +
    geom_line(data=dat_mesh2y, size=.3, aes(x=time, y=rss, color=alloc, group=5)) +
    ## geom_line(data=dat_mesh3, size=.3, aes(x=time, y=rss, color=alloc, group=7)) +
    ## geom_line(data=dat_glibc, linetype='dashed', size=.3, aes(x=time, y=rss, color=alloc, group=5)) +
    ## geom_line(data=dat_tcmalloc, size=.3, aes(x=time, y=rss, color=alloc, group=3)) +
    geom_line(data=dat_jemalloc, linetype='dotted', size=.4, aes(x=time, y=rss, color=alloc, group=4)) +
    ## geom_line(data=dat_hoard, size=.3, aes(x=time, y=rss, color=alloc, group=5)) +
    ## geom_line(data=dat_diehard, size=.3, aes(x=time, y=rss, color=alloc, group=8)) +
    scale_y_continuous('RSS (MiB)', expand = c(0, 0), limits = c(0, 300)) +
    scale_x_continuous('Time Since Program Start (seconds)', expand = c(0, 0), limits = c(0, 3.0)) +
    theme_bw(10, 'Times') +
    guides(colour = guide_legend(nrow = 1)) +
    theme(
        plot.title = element_text(size=10, face='bold'),
        strip.background = element_rect(color='dark gray', linetype=0.5),
        plot.margin = unit(c(.1, .1, 0, 0), 'in'),
        panel.border = element_rect(colour='gray'),
        panel.margin = unit(c(0, 0, -0.5, 0), 'in'),
        legend.position = 'bottom',
        legend.key = element_rect(color=NA),
        legend.key.size = unit(0.15, 'in'),
        legend.margin = unit(0, 'in'),
        legend.title=element_blank(),
        axis.title.y = element_text(size=9),
        axis.text.x = element_text(angle = 0, hjust = 1)
    )

ggsave(p, filename='ruby-frag.pdf', width=3.4, height=1.5)
