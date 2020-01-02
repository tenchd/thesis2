library(ggplot2)
library(grid)
library(scales)

library(forcats)
library(dplyr)


dat <- read.delim('../data/redis-perf.tsv', header = TRUE)
print (dat)

dat <- dat %>%
    mutate(allocator = fct_relevel(allocator, "libc", "jemalloc", "tcmalloc", "hoard", "diehard", "mesh-alwayson", "mesh")) %>%
    mutate(allocator = fct_recode(allocator,
                                  "glibc" = "libc",
                                  "Hoard" = "hoard",
                                  "DieHard" = "diehard",
                                  "Mesh (always on)" = "mesh-alwayson",
                                  "Mesh (activedefrag no)" = "mesh"))


p <-
    ggplot(data=dat, aes(x='', y=elapsed, fill=allocator)) +
    geom_bar(stat='summary', y.fun='mean', position=position_dodge(), width=.8) +
    scale_x_discrete('Benchmark', expand = c(0, 0)) +
    scale_y_continuous('Time to insert 870,000 objects in LRU (Seconds)', expand = c(0, 0)) +
    coord_cartesian(ylim=c(0, 3)) +
    theme_bw(10, 'Times') +
    guides(fill = guide_legend(nrow = 2)) +
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
        axis.text.x = element_text(angle = 45, hjust = 1)
    )

ggsave(p, filename='redis-perf.pdf', width=3.4, height=2.5)
