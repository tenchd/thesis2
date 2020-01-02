library(ggplot2)
library(grid)
library(scales)

dat_mesh <- read.delim('../data/leveldb.db_bench.mesh.tsv', header = TRUE, sep = '\t')
dat_mesh$alloc <- 'Mesh'
dat_mesh$rss <- dat_mesh$rss / 1024.0 / 1024.0
dat_mesh$time <- dat_mesh$time / 1000000000.0

dat_mesh_arena <- read.delim('../data/leveldb.db_bench.mesh-arenas.tsv', header = TRUE, sep = '\t')
dat_mesh_arena$alloc <- 'Mesh (Arenas enabled)'
dat_mesh_arena$rss <- dat_mesh_arena$rss / 1024.0 / 1024.0
dat_mesh_arena$time <- dat_mesh_arena$time / 1000000000.0

dat_tcmalloc <- read.delim('../data/leveldb.db_bench.tcmalloc.tsv', header = TRUE, sep = '\t')
dat_tcmalloc$alloc <- 'TCMalloc'
dat_tcmalloc$rss <- dat_tcmalloc$rss / 1024.0 / 1024.0
dat_tcmalloc$time <- dat_tcmalloc$time / 1000000000.0


p <- ggplot() +
    geom_line(data=dat_mesh, size=.3, aes(x=time, y=rss, color=alloc, group=1)) +
    geom_line(data=dat_mesh_arena, size=.3, aes(x=time, y=rss, color=alloc, group=2)) +
    geom_line(data=dat_tcmalloc, size=.3, aes(x=time, y=rss, color=alloc, group=8)) +
    scale_y_continuous('RSS (MiB)', expand = c(0, 0), limits = c(0, 130)) +
    scale_x_continuous('Time Since Program Start (seconds)', expand = c(0, 0), limits = c(0, 16.0)) +
    theme_bw(10, 'Times') +
    guides(colour = guide_legend(nrow = 3)) +
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

ggsave(p, filename='leveldb_db_bench.pdf', width=3.4, height=2.5)
