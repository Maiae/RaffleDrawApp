#
# Raffle Draw App by Eduardo Maia
# 

library(shiny)
library(DT)

draw <- function(tickets, prizes) {
	result <- data.frame(winners = sample(1:tickets, prizes, replace = FALSE))
	return(data.frame(winners = sort(result$winners)))
}

#### UI ####
ui <- shinyUI(fluidPage(
	# Application title and header
	titlePanel(img(src = "buzz_logo.jpeg", height = '50%', weight= '50%'), windowTitle = "Raffle Draw"),
#	headerPanel(h2("Raffle Draw")),
	
	# Sidebar with input fields
	sidebarLayout(
		sidebarPanel(
			numericInput("tickets",
									 label = "Number Tickets:",
									 value = 400),
			numericInput("prizes",
									 label = "Number Prizes:",
									 value = 40),
			actionButton("do", "Draw")
		),

		# Show output in able format
		mainPanel(headerPanel(h2("Winners")), tableOutput("mytable"))
	)
))


#### SERVER ####
server <- function(input, output) {
	# run draw function and save results
	result <- eventReactive(input$do, {
		draw(input$tickets, input$prizes)
	})
	
	# display results
	output$mytable <- renderTable({
		data.frame(cbind(result()[1:5, ], result()[6:10, ], result()[11:15, ], result()[16:20, ],
										 result()[21:25, ], result()[26:30, ], result()[31:35, ], result()[36:40, ]))
	}, include.rownames = FALSE
	, include.colnames = FALSE)
}


# Run the application 
shinyApp(ui = ui, server = server)
