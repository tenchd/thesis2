library(ggplot2)
library(grid)
library(scales)

dat_mesh <- read.delim('../data/python-big3/mesh_mesh.tsv', header = TRUE, sep = '\t')
dat_mesh$alloc <- 'Mesh (meshing)'
dat_mesh$rss <- dat_mesh$rss / 1024.0 / 1024.0
dat_mesh$time <- dat_mesh$time / 1000000000.0

dat_mesh2 <- read.delim('../data/python-big3/mesh_nomesh.tsv', header = TRUE, sep = '\t')
dat_mesh2$alloc <- 'Mesh (no meshing)'
dat_mesh2$rss <- dat_mesh2$rss / 1024.0 / 1024.0
dat_mesh2$time <- dat_mesh2$time / 1000000000.0

## dat_mesh3 <- read.delim('../data/python-big3/mesh3.tsv', header = TRUE, sep = '\t')
## dat_mesh3$alloc <- 'Mesh (meshing, no madvise+fallocate)'
## dat_mesh3$rss <- dat_mesh3$rss / 1024.0 / 1024.0
## dat_mesh3$time <- dat_mesh3$time / 1000000000.0

dat_glibc <- read.delim('../data/python-big3/glibc.tsv', header = TRUE, sep = '\t')
dat_glibc$alloc <- 'glibc'
dat_glibc$rss <- dat_glibc$rss / 1024.0 / 1024.0
dat_glibc$time <- dat_glibc$time / 1000000000.0

## dat_glibc2 <- read.delim('../data/python-big3/glibc2.tsv', header = TRUE, sep = '\t')
## dat_glibc2$alloc <- 'glibc2'
## dat_glibc2$rss <- dat_glibc2$rss / 1024.0 / 1024.0
## dat_glibc2$time <- dat_glibc2$time / 1000000000.0

dat_tcmalloc <- read.delim('../data/python-big3/tcmalloc.tsv', header = TRUE, sep = '\t')
dat_tcmalloc$alloc <- 'tcmalloc'
dat_tcmalloc$rss <- dat_tcmalloc$rss / 1024.0 / 1024.0
dat_tcmalloc$time <- dat_tcmalloc$time / 1000000000.0

dat_jemalloc <- read.delim('../data/python-big3/jemalloc.tsv', header = TRUE, sep = '\t')
dat_jemalloc$alloc <- 'jemalloc'
dat_jemalloc$rss <- dat_jemalloc$rss / 1024.0 / 1024.0
dat_jemalloc$time <- dat_jemalloc$time / 1000000000.0

dat_hoard <- read.delim('../data/python-big3/hoard.tsv', header = TRUE, sep = '\t')
dat_hoard$alloc <- 'Hoard'
dat_hoard$rss <- dat_hoard$rss / 1024.0 / 1024.0
dat_hoard$time <- dat_hoard$time / 1000000000.0

dat_pymalloc <- read.delim('../data/python-big3/pymalloc.tsv', header = TRUE, sep = '\t')
dat_pymalloc$alloc <- 'pymalloc'
dat_pymalloc$rss <- dat_pymalloc$rss / 1024.0 / 1024.0
dat_pymalloc$time <- dat_pymalloc$time / 1000000000.0

p <- ggplot() +
    geom_line(data=dat_mesh, size=.2, aes(x=time, y=rss, color=alloc, group=1)) +
    geom_line(data=dat_mesh2, size=.2, aes(x=time, y=rss, color=alloc, group=7)) +
    ## geom_line(data=dat_mesh3, size=.2, aes(x=time, y=rss, color=alloc, group=8)) +
    ## geom_line(data=dat_glibc, linetype='dashed', size=.2, aes(x=time, y=rss, color=alloc, group=2)) +
    ## geom_line(data=dat_glibc2, linetype='dashed', size=.3, aes(x=time, y=rss, color=alloc, group=3)) +
    geom_line(data=dat_tcmalloc, size=.2, aes(x=time, y=rss, color=alloc, group=4)) +
    ## geom_line(data=dat_jemalloc, size=.2, aes(x=time, y=rss, color=alloc, group=5)) +
    ## geom_line(data=dat_hoard, size=.2, aes(x=time, y=rss, color=alloc, group=6)) +
    geom_line(data=dat_pymalloc, size=.2, aes(x=time, y=rss, color=alloc, group=9)) +
    scale_y_continuous('RSS (MiB)', expand = c(0, 0), limits = c(0, 800)) +
    scale_x_continuous('Time Since Program Start (seconds)', expand = c(0, 0), limits = c(0, 4.5)) +
    ## scale_y_continuous('RSS (MiB)', expand = c(0, 0), limits = c(0, 250)) +
    ## scale_x_continuous('Time Since Program Start (seconds)', expand = c(0, 0), limits = c(0, 4.5)) +
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

ggsave(p, filename='python3-big3.pdf', width=6.4, height=3)
