library(ggplot2)
library(grid)
library(scales)

dat_mesh0n <- read.delim('../data/redis-latency/mesh0n.free.csv', header = TRUE, sep = ',')
dat_mesh0n$alloc <- 'Mesh 0n'

dat_mesh1n <- read.delim('../data/redis-latency/mesh1n.free.csv', header = TRUE, sep = ',')
dat_mesh1n$alloc <- 'Mesh 1n'

dat_mesh2n <- read.delim('../data/redis-latency/mesh2n.free.csv', header = TRUE, sep = ',')
dat_mesh2n$alloc <- 'Mesh 2n'

dat_mesh2y <- read.delim('../data/redis-latency/mesh2y.free.csv', header = TRUE, sep = ',')
dat_mesh2y$alloc <- 'Mesh 2y (new)'

## dat_hoard <- read.delim('../data/redis-latency/malloc.hoard.csv', header = TRUE, sep = ',')
## dat_hoard$alloc <- 'Hoard'

## dat_diehard <- read.delim('../data/git-latency/latency.diehard', header = TRUE, sep = ',')
## dat_diehard$alloc <- 'DieHard'

## dat_glibc <- read.delim('../data/git-latency/latency.glibc', header = TRUE, sep = ',')
## dat_glibc$alloc <- 'glibc'

dat_jemalloc <- read.delim('../data/redis-latency/jemalloc-external.free.csv', header = TRUE, sep = ',')
dat_jemalloc$alloc <- 'jemalloc'

dat_tcmalloc <- read.delim('../data/redis-latency/tcmalloc-external.free.csv', header = TRUE, sep = ',')
dat_tcmalloc$alloc <- 'tcmalloc'

dat_hoard <- read.delim('../data/redis-latency/hoard.free.csv', header = TRUE, sep = ',')
dat_hoard$alloc <- 'hoard'


p <- ggplot() + #dat_mesh, aes(time, color=alloc)) +
    geom_line(data=dat_mesh0n, size=.3, aes(x=Value, y=Percentile, color=alloc, group=1)) +
    ## geom_line(data=dat_mesh1n, size=.3, aes(x=Value, y=Percentile, color=alloc, group=2)) +
    ## geom_line(data=dat_mesh2n, size=.3, aes(x=Value, y=Percentile, color=alloc, group=3)) +
    geom_line(data=dat_mesh2y, size=.3, aes(x=Value, y=Percentile, color=alloc, group=4)) +
    ## geom_line(data=dat_mesh1n, size=.3, aes(x=Value, y=Percentile, color=alloc, group=6)) +
    ## geom_line(data=dat_mesh2n, size=.3, aes(x=Value, y=Percentile, color=alloc, group=8)) +
    geom_line(data=dat_jemalloc, size=.3, aes(x=Value, y=Percentile, color=alloc, group=5)) +
    ## geom_line(data=dat_tcmalloc, size=.3, aes(x=Value, y=Percentile, color=alloc, group=6)) +
    ## geom_line(data=dat_hoard, size=.3, aes(x=Value, y=Percentile, color=alloc, group=7)) +
    ## stat_ecdf(geom = "step", data=dat_mesh, size=.3, aes(x=Value, color=alloc, group=1)) +
    ## stat_ecdf(geom = "step", data=dat_glibc, size=.3, aes(x=Value, color=alloc, group=2)) +
    ## stat_ecdf(geom = "step", data=dat_jemalloc, size=.3, aes(x=Value, color=alloc, group=4)) +
    ## stat_ecdf(geom = "step", data=dat_hoard, size=.3, aes(x=Value, color=alloc, group=5)) +
    ## stat_ecdf(geom = "step", data=dat_diehard, size=.3, aes(x=Value, color=alloc, group=8)) +
    ## stat_ecdf(geom = "step", data=dat_tcmalloc, size=.3, aes(x=Value, color=alloc, group=7)) +
    coord_cartesian(xlim = c(0, 300)) +
    scale_x_continuous('Time (nanoseconds)') +
    scale_y_continuous('Cumulative fraction of requests') +
    theme_bw(10, 'Times') +
    guides(colour = guide_legend(nrow = 2)) +
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

ggsave(p, filename='latency-free.pdf', width=3.4, height=2.5)
