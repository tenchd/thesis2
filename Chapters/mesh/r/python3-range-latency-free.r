library(ggplot2)
library(grid)
library(scales)

dat_mesh <- read.delim('../data/py/xrange-mesh-free.csv', header = TRUE, sep = ',')
dat_mesh$alloc <- 'Mesh'

dat_glibc <- read.delim('../data/py/xrange-glibc-free.csv', header = TRUE, sep = ',')
dat_glibc$alloc <- 'glibc'

dat_jemalloc <- read.delim('../data/py/xrange-jemalloc-free.csv', header = TRUE, sep = ',')
dat_jemalloc$alloc <- 'jemalloc'

dat_tcmalloc <- read.delim('../data/py/xrange-tcmalloc-free.csv', header = TRUE, sep = ',')
dat_tcmalloc$alloc <- 'tcmalloc'

dat_hoard <- read.delim('../data/py/xrange-hoard-free.csv', header = TRUE, sep = ',')
dat_hoard$alloc <- 'hoard'


p <- ggplot() + #dat_mesh, aes(time, color=alloc)) +
    geom_line(data=dat_mesh, size=.3, aes(x=Value, y=Percentile, color=alloc, group=1)) +
    geom_line(data=dat_glibc, size=.3, aes(x=Value, y=Percentile, color=alloc, group=2)) +
    geom_line(data=dat_jemalloc, size=.3, aes(x=Value, y=Percentile, color=alloc, group=3)) +
    geom_line(data=dat_tcmalloc, size=.3, aes(x=Value, y=Percentile, color=alloc, group=4)) +
    geom_line(data=dat_hoard, size=.3, aes(x=Value, y=Percentile, color=alloc, group=5)) +
    coord_cartesian(xlim = c(0, 600)) +
    scale_x_continuous('Time (nanoseconds)') +
    scale_y_continuous('Cumulative fraction of requests') +
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

ggsave(p, filename='python3-range-latency-free.pdf', width=3.4, height=2.5)
