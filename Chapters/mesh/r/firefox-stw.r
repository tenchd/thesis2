library(ggplot2)
library(grid)
library(scales)

dat_stw <- read.delim('../data/firefox-stw-pause.tsv', header = TRUE, sep = '\t')
dat_stw$alloc <- 'Mesh'

quantile(dat_stw$time, c(.90, .95, .99))


p <- ggplot() +
    stat_ecdf(geom = "step", data=dat_stw, size=.3, aes(x=time, color=alloc, group=1)) +
    coord_cartesian(xlim = c(0, 5000000)) +
    scale_x_continuous('Time (nanoseconds)') +
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

## p <- ggplot() +
##     geom_line(data=dat_mesh, size=.3, aes(x=time, y=rss, color=alloc, group=1)) +
##     geom_line(data=dat_mesh3, size=.3, aes(x=time, y=rss, color=alloc, group=7)) +
##     geom_line(data=dat_glibc, size=.3, aes(x=time, y=rss, color=alloc, group=2)) +
##     geom_line(data=dat_tcmalloc, size=.3, aes(x=time, y=rss, color=alloc, group=3)) +
##     geom_line(data=dat_jemalloc, size=.3, aes(x=time, y=rss, color=alloc, group=4)) +
##     geom_line(data=dat_hoard, size=.3, aes(x=time, y=rss, color=alloc, group=5)) +
##     geom_line(data=dat_diehard, size=.3, aes(x=time, y=rss, color=alloc, group=8)) +
##     scale_y_continuous('RSS (MiB)', expand = c(0, 0), limits = c(0, 512)) +
##     scale_x_continuous('Time Since Program Start (seconds)', expand = c(0, 0), limits = c(0, 7.5)) +
##     theme_bw(10, 'Times') +
##     guides(colour = guide_legend(nrow = 3)) +
##     theme(
##         plot.title = element_text(size=10, face='bold'),
##         strip.background = element_rect(color='dark gray', linetype=0.5),
##         plot.margin = unit(c(.1, .1, 0, 0), 'in'),
##         panel.border = element_rect(colour='gray'),
##         panel.margin = unit(c(0, 0, -0.5, 0), 'in'),
##         legend.position = 'bottom',
##         legend.key = element_rect(color=NA),
##         legend.key.size = unit(0.15, 'in'),
##         legend.margin = unit(0, 'in'),
##         legend.title=element_blank(),
##         axis.title.y = element_text(size=9),
##         axis.text.x = element_text(angle = 0, hjust = 1)
##     )

ggsave(p, filename='firefox-stw.pdf', width=3.4, height=2.5)
