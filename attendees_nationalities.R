library(tabulizer)
library(dplyr)

attendees_pdf <- 'State_of_the_Map_2018_attendees.pdf'
attendees_table <- extract_tables(attendees_pdf)

attendees <- attendees_table[-length(attendees_table)]

attendees <- as.data.frame(do.call(rbind, attendees))

colnames(attendees) <- as.character(unlist(attendees[1,]))
attendees <- attendees[-1,]
rownames(attendees) <- NULL

last <- attendees_table[[length(attendees_table)]]
last_table <- data.frame('First Name' = last[, 1], 'Last Name' = NA,
                         'Name on\rattendee list' = NA, 'Company Name' = NA,
                         'Country' = last[, 2], check.names = FALSE)

attendees <- rbind(attendees, last_table)
attendees <- attendees %>% rename('Name on attendee list' = 'Name on\rattendee list')
write.csv(attendees, file = 'attendees.csv', row.names = FALSE)

