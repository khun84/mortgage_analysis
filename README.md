# README

Authored at:  
19 Oct 2017

## Why Mortgage Analysis?
When users undertake a mortgage position, one of their biggest concern is the profit and loss when they exit the mortgage position. Most of the prevailing property listing and financial services portal do offer a basic mortgage calculator feature. 

However, almost none of them take one step further to at least give an indicative answer of **"How much money do I make or loss at the end of the day?"**

Under this premise, **Mortgage Analysis** aspires to fill in the gap and help the users to make a more informed decision in their property investment undertaking.

## What does [Mortgage Analysis](https://mortgage-analysis.herokuapp.com/) app do?
**Mortgage Analysis** is an app to help users analyse their mortgage position. It can run the analysis in 2 mode (see below) and return the IRR % (internal return rate) to the user for evaluation purpose:
1. **Basic analysis (for non-registered user)**  
The basic mode only accepts very basic mortgage input without factored in additional income or expenses that users might encounter in real life situation.
2. **Advance analysis (for registered user)**  
On top of the basic analysis, advance mode provides the following features.
    - **Additional input on income and expenses cash flow**, currently support rental income, lump sum buying and selling transaction cost
    - **Save the analysis as a project** for reference, currently support multiple projects per user without limit.
    - Each project could have **multiple scenarios** to compare the impact of different mortgage parameters. This is useful when the users want to compare different rates, buying price and selling price offered by different parties.

## Future improvement
1. **Beef up the front-end** for better user experience
2. **Break down the lump sum transaction cost** into configurable common cost elements, such as **stamp duty**, **agent fee**, **legal fee**, **property income tax** and **housing insurance**.
3. **Incorporate mortgage rate changes** in the analysis to reflect its impact on IRR
3. **Display historical/latest/forecast data of BLR and FD rate** for reference purpose
4. **Enrich the analysis input parameters** with prevailing bank offering rate, property agents services and legal advise services.
5. Incorporate **third party professional panels** to provide professional advises to users

## Potential monetization tactics
1. **Subscription based** for users that require advance analysis and information enrichment
2. **Ads display** for related professional services offering
2. **O2O (Online to Offline) traffic diversion** by matching professional advises request (active/passive triggering) to professional panels registered with the app.

You may try **Mortgage Analysis** at [https://mortgage-analysis.herokuapp.com/](https://mortgage-analysis.herokuapp.com/)