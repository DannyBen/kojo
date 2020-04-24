Movie Request Form
==================================================

- **Requested By**: {{ ask "Your Name:" }}
- **Requested On**: {{ today }}
- **Preferred Genre**: {{ select "Preferred Genre:", genres }}

(( if yes? "Would you like snacks with your movie?" ))
Snacks
--------------------------------------------------

(( loop do ))
- {{ select "Select Snack:", snacks }}
(( break unless yes? "Do you want another snack?" ))
(( end ))
(( end ))

