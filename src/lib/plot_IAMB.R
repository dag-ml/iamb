# Graphviz plot attributes
graph_attrs <- list(rankdir = "BT", size = "5,5", bgcolor = "white")
node_attrs <- list(fontcolor = "black", shape = "circle", style = "filled", fillcolor = "lightyellow")
edge_attrs <- list(color = "black")

# Plot the DAG
plot_dag <- function(graph, algo){
    plot_title <- paste0(algo, " 😲🐭 ", title)
    plot(graph, attrs = list(graph = graph_attrs, node = node_attrs, edge = edge_attrs))
    title(plot_title, line = -2, cex.main = 2)
}

par(mfrow = c(2,2))

# Learn the DAG structure
algorithms <- c("iamb", "fast.iamb", "inter.iamb", "iamb.fdr")
graphs <- list()
for (algo in algorithms) {
    dag <- switch(algo,
        "iamb" = iamb(dsub_set),
        "fast.iamb" = fast.iamb(dsub_set),
        "inter.iamb" = inter.iamb(dsub_set),
        "iamb.fdr" = iamb.fdr(dsub_set)
    )
    graph <- as.graphNEL(cextend(dag))
    graphs[[algo]] <- graph
    plot_dag(graph, algo)
}