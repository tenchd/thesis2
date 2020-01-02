library(ggplot2)
library(grid)
library(scales)

dat <- read.delim('../data/lru-histogram.tsv', header = TRUE, sep = '\t')

p <- ggplot(data=dat) +
    geom_line(linetype='dashed', aes(x=occupancy, y=before, color='Before Meshing')) +
    geom_line(aes(x=occupancy, y=after, color='After Meshing')) +
    ## geom_line(aes(x=Occupancy, y='After Meshing')) +
    scale_y_continuous('Number of Spans', expand = c(0, 0)) +
    scale_x_discrete('Occupancy (%)', expand = c(0, 0)) +
    theme_minimal() +
    theme_bw(10, 'Times') +
    guides(colour = guide_legend(reverse=TRUE)) +
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

ggsave(p, filename='lru-histogram.pdf', width=3.4, height=1.5)
