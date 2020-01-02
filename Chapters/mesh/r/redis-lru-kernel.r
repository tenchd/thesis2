library(ggplot2)
library(grid)
library(scales)

## dat_mesh <- read.delim('../data/redis-lru/redis-lru-mesh.tsv', header = TRUE, sep = '\t')
## dat_mesh$alloc <- 'Mesh (activedefrag)'
## dat_mesh$kernel <- dat_mesh$kernel / 1024.0 / 1024.0
## dat_mesh$time <- dat_mesh$time / 1000000000.0

## dat_mesh2 <- read.delim('../data/redis-lru/redis-lru-mesh-old.tsv', header = TRUE, sep = '\t')
## dat_mesh2$alloc <- 'mesh-old'
## dat_mesh2$kernel <- dat_mesh2$kernel / 1024.0 / 1024.0
## dat_mesh2$time <- dat_mesh2$time / 1000000000.0

dat_mesh3 <- read.delim('../data/redis-lru/redis-lru-mesh2y.tsv', header = TRUE, sep = '\t')
dat_mesh3$alloc <- 'Mesh'
dat_mesh3$kernel <- dat_mesh3$kernel / 1024.0 / 1024.0
dat_mesh3$time <- dat_mesh3$time / 1000000000.0

dat_glibc <- read.delim('../data/redis-lru/redis-lru-libc.tsv', header = TRUE, sep = '\t')
dat_glibc$alloc <- 'glibc'
dat_glibc$kernel <- dat_glibc$kernel / 1024.0 / 1024.0
dat_glibc$time <- dat_glibc$time / 1000000000.0

dat_tcmalloc <- read.delim('../data/redis-lru/redis-lru-tcmalloc.tsv', header = TRUE, sep = '\t')
dat_tcmalloc$alloc <- 'tcmalloc'
dat_tcmalloc$kernel <- dat_tcmalloc$kernel / 1024.0 / 1024.0
dat_tcmalloc$time <- dat_tcmalloc$time / 1000000000.0

dat_jemalloc <- read.delim('../data/redis-lru/redis-lru-jemalloc.tsv', header = TRUE, sep = '\t')
dat_jemalloc$alloc <- 'jemalloc (activedefrag)'
dat_jemalloc$kernel <- dat_jemalloc$kernel / 1024.0 / 1024.0
dat_jemalloc$time <- dat_jemalloc$time / 1000000000.0

dat_hoard <- read.delim('../data/redis-lru/redis-lru-hoard.tsv', header = TRUE, sep = '\t')
dat_hoard$alloc <- 'Hoard'
dat_hoard$kernel <- dat_hoard$kernel / 1024.0 / 1024.0
dat_hoard$time <- dat_hoard$time / 1000000000.0

## dat_diehard <- read.delim('../data/redis-lru/redis-lru-diehard.tsv', header = TRUE, sep = '\t')
## dat_diehard$alloc <- 'DieHard'
## dat_diehard$kernel <- dat_diehard$kernel / 1024.0 / 1024.0
## dat_diehard$time <- dat_diehard$time / 1000000000.0

p <- ggplot() +
    geom_line(data=dat_mesh3, size=.3, aes(x=time, y=kernel, color=alloc, group=1)) +
    ## geom_line(data=dat_mesh3, size=.3, aes(x=time, y=kernel, color=alloc, group=7)) +
    geom_line(data=dat_glibc, linetype='dashed', size=.3, aes(x=time, y=kernel, color=alloc, group=2)) +
    ## geom_line(data=dat_tcmalloc, size=.3, aes(x=time, y=kernel, color=alloc, group=3)) +
    geom_line(data=dat_jemalloc, linetype='dotted', size=.4, aes(x=time, y=kernel, color=alloc, group=4)) +
    ## geom_line(data=dat_hoard, size=.3, aes(x=time, y=kernel, color=alloc, group=5)) +
    ## geom_line(data=dat_diehard, size=.3, aes(x=time, y=kernel, color=alloc, group=8)) +
    scale_y_continuous('KERNEL (MiB)', expand = c(0, 0), limits = c(0, 20)) +
    scale_x_continuous('Time Since Program Start (seconds)', expand = c(0, 0), limits = c(0, 6.0)) +
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

ggsave(p, filename='redis-lru-kernel.pdf', width=3.4, height=1.5)
