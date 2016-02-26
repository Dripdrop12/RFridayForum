setwd("~/Internal Projects/Friday Forum")
# ----------------- #
# Required software #
# ----------------- #
require(shiny)
require(shinyjs)
require(dplyr)
require(plotly)
require(googleVis)
require(DT)

# Define server logic for random distribution application
server <- function(input, output) {
    
    # Reactive expression to generate the requested distribution.
    # This is called whenever the inputs change. The output
    # functions defined below then all use the value computed from
    # this expression
    data <- reactive({
        dist <- switch(input$dist,
                       norm = rnorm,
                       unif = runif,
                       lnorm = rlnorm,
                       exp = rexp,
                       rnorm)
        
        dist(input$n)
    })
    
    # Generate a plot of the data. Also uses the inputs to build
    # the plot label. Note that the dependencies on both the inputs
    # and the data reactive expression are both tracked, and
    # all expressions are called in the sequence implied by the
    # dependency graph
    output$plot <- renderPlotly({
        plot_ly(x=data(), type = "histogram", opacity=.5) %>%
            add_trace(x = rnorm(500)+1)
    })
    
    # Generate a summary of the data
    output$summary <- renderPrint({
        summary(data())
    })
    
    # Generate an HTML table view of the data
    output$table <- renderDataTable({
        DT::datatable(data.frame(x=data()),
            style = 'bootstrap')
    })
    
}


# Define UI for random distribution application 
ui <- fluidPage(theme = 'united.css',
    
    # Application title
    titlePanel("Tabsets"),
    
    # Sidebar with controls to select the random distribution type
    # and number of observations to generate. Note the use of the
    # br() element to introduce extra vertical spacing
    sidebarLayout(
        sidebarPanel(
            radioButtons("dist", "Distribution type:",
                         c("Normal" = "norm",
                           "Uniform" = "unif",
                           "Log-normal" = "lnorm",
                           "Exponential" = "exp")),
            br(),
            
            sliderInput("n", 
                        "Number of observations:", 
                        value = 500,
                        min = 1, 
                        max = 1000,
                        animate = T)
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Plot", 
                                 icon = icon('bar-chart'), 
                                 plotlyOutput("plot")), 
                        tabPanel("Summary", icon = icon('gears'),
                                 verbatimTextOutput("summary")), 
                        tabPanel("Table", icon = icon('table'), 
                                 DT::dataTableOutput("table"))
            )
        )
    )
)

shinyApp(ui = ui, server = server)