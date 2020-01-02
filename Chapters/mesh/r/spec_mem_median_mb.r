library(ggplot2)
library(grid)
library(scales)

library(forcats)
library(dplyr)


dat <- read.delim('../data/spec_results_speed.tsv', header = TRUE) %>%
    mutate(allocator = fct_relevel(allocator, "glibc", "jemalloc", "hoard", "diehard", "mesh-pow2", "mesh-jesize")) %>%
    mutate(allocator = fct_recode(allocator,
                                  "Hoard" = "hoard",
                                  "DieHard" = "diehard",
                                  "Mesh" = "mesh-jesize",
                                  "Mesh (power-of-two size classes)" = "mesh-pow2"),
           benchmark = fct_recode(benchmark,
                                  "average" = "geomean"))

p <-
    ggplot(data=dat, aes(x=benchmark, y=mem_median_mb, fill=allocator)) +
    geom_bar(stat='identity', position=position_dodge(), width=.8) +
    scale_x_discrete('Benchmark', expand = c(0, 0)) +
    scale_y_continuous('Median RSS (MiB)', expand = c(0, 0)) +
    coord_cartesian(ylim=c(0, 1800)) +
    theme_bw(10, 'Times') +
    guides(fill = guide_legend(nrow = 1)) +
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


ggsave(p, filename='spec_mem_median_mb.pdf', width=7, height=2.75)
