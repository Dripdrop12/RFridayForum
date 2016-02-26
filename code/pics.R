require(DiagrammeR)

# input and output
grViz("digraph {
    graph [rankdir=LR; overlap=false]
    c -> b ; g -> b; b->g; g -> c ;  e -> b; h -> a [label='session info', style=bold];
    b -> a [label='output', style=bold];
    a -> b [label='input', style=bold];
    f -> b; a -> f [label='session events']; d -> a [label='styling'];
    subgraph cluster0 {c; e;  label='initialization'}
    
    node [shape=oval, fontname=Lato, fontsize=16]
    a [label='ui.R', shape=box];
    b [label='server.R', shape=box];
    c [label='global.R'];
    d [label='.css'];
    e [label='helpers.R'];
    f [label='.js'];
    g [label='Database', shape=parallelogram];
    h [label='User', shape=egg]
}")

# Render
grViz("digraph {
      graph [rankdir = LR]
      
      node [shape = box,
        fontname = Lato,
        fontsize = 16]
        out_z; 

      node [shape = oval] in_a;

      in_a->out_z}")
# Reactive expression
grViz("digraph {
      graph [rankdir = LR]
      
      node [shape = box,
        fontname = Lato,
        fontsize = 16]
        out_z; out_y; x

      node [shape = oval] in_a;

      in_a->x x->out_z x->out_y}")
# DiagrammeR::mermaid("
#                     graph LR
#                     A(input$a) --> C[x];
# C[x]-->B[output$z]; C[x]-->D[output$y]
#                     ")
# Isolate
grViz("digraph {
      graph [rankdir = LR]
      
      node [shape = box,
        fontname = Lato,
        fontsize = 16]
        out_z; 

      node [shape = oval] in_a; in_b

      in_b->out_z}")

# Observe
DiagrammeR::mermaid("
                    graph LR 
                    A(input$submit) --> C[Observer]
                    ")
grViz("digraph {
      graph [rankdir = LR]
      
      node [shape = box,
        fontname = Lato,
        fontsize = 16]
        observer; 

      node [shape = oval] in_submit

      in_submit->observer}")