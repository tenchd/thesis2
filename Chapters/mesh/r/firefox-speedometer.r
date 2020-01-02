library(ggplot2)
library(grid)
library(scales)

dat_mesh <- read.delim('../data/mesh-speedometer.tsv', header = TRUE, sep = '\t')
dat_mesh$alloc <- 'Mesh'
dat_mesh$rss <- dat_mesh$rss / 1024.0 / 1024.0
dat_mesh$time <- dat_mesh$time / 1000000000.0

dat_mesh2 <- read.delim('../data/speedometer-mstats/speedometer.mesh2y.1542183480.051526866-a8f57657.tsv', header = TRUE, sep = '\t')
dat_mesh2$alloc <- 'Mesh'
dat_mesh2$rss <- dat_mesh2$rss / 1024.0 / 1024.0
dat_mesh2$time <- dat_mesh2$time / 1000000000.0

dat_jemalloc <- read.delim('../data/mozjemalloc-speedometer.tsv', header = TRUE, sep = '\t')
dat_jemalloc$alloc <- 'mozjemalloc'
dat_jemalloc$rss <- dat_jemalloc$rss / 1024.0 / 1024.0
dat_jemalloc$time <- dat_jemalloc$time / 1000000000.0

dat_jemalloc2 <- read.delim('../data/mozjemalloc-speedometer.2.tsv', header = TRUE, sep = '\t')
dat_jemalloc2$alloc <- 'mozjemalloc (2)'
dat_jemalloc2$rss <- dat_jemalloc2$rss / 1024.0 / 1024.0
dat_jemalloc2$time <- dat_jemalloc2$time / 1000000000.0

dat_vanilla <- read.delim('../data/vanilla-speedometer.tsv', header = TRUE, sep = '\t')
dat_vanilla$alloc <- 'compiled-in'
dat_vanilla$rss <- dat_vanilla$rss / 1024.0 / 1024.0
dat_vanilla$time <- dat_vanilla$time / 1000000000.0

dat_vanilla2 <- read.delim('../data/speedometer-mstats/speedometer.jemalloc.1542182865.120024199-573a575f.tsv', header = TRUE, sep = '\t')
dat_vanilla2$alloc <- 'default jemalloc'
dat_vanilla2$rss <- dat_vanilla2$rss / 1024.0 / 1024.0
dat_vanilla2$time <- dat_vanilla2$time / 1000000000.0

p <- ggplot() +
    geom_line(data=dat_mesh2, size=.5, aes(x=time, y=rss, color=alloc, group=1)) +
    ## geom_line(data=dat_mesh2, size=.3, aes(x=time, y=rss, color=alloc, group=2)) +
    ## geom_line(data=dat_mesh3, size=.3, aes(x=time, y=rss, color=alloc, group=7)) +
    ## geom_line(data=dat_glibc, size=.3, aes(x=time, y=rss, color=alloc, group=2)) +
    ## geom_line(data=dat_tcmalloc, size=.3, aes(x=time, y=rss, color=alloc, group=3)) +
    ## geom_line(data=dat_vanilla, size=.3, aes(x=time, y=rss, color=alloc, group=7)) +
    geom_line(data=dat_vanilla2, size=.5, aes(x=time, y=rss, color=alloc, group=8)) +
    ## geom_line(data=dat_jemalloc, size=.3, aes(x=time, y=rss, color=alloc, group=4)) +
    ## geom_line(data=dat_jemalloc2, size=.3, aes(x=time, y=rss, color=alloc, group=5)) +
    ## geom_line(data=dat_hoard, size=.3, aes(x=time, y=rss, color=alloc, group=5)) +
    ## geom_line(data=dat_diehard, size=.3, aes(x=time, y=rss, color=alloc, group=8)) +
    scale_y_continuous('RSS (MiB)', expand = c(0, 0), limits = c(0, 820)) +
    scale_x_continuous('Time Since Program Start (seconds)', expand = c(0, 0), limits = c(0, 144)) +
    theme_bw(20, 'Times') +
    guides(colour = guide_legend(nrow = 1)) +
    theme(
        plot.title = element_text(size=10, face='bold'),
        strip.background = element_rect(color='dark gray', linetype=0.5),
        plot.margin = unit(c(.1, .1, 0.1, 0), 'in'),
        panel.border = element_rect(colour='gray'),
        panel.margin = unit(c(0, 0, 0, 0), 'in'),
        legend.position = 'bottom',
        legend.key = element_rect(color=NA),
        legend.key.size = unit(0.15, 'in'),
        legend.margin = unit(0.1, 'in'),
        legend.title=element_blank(),
        axis.title.y = element_text(size=20),
        axis.text.x = element_text(angle = 0, hjust = 1)
    )

ggsave(p, filename='firefox-speedometer.pdf', width=7, height=2.75)
