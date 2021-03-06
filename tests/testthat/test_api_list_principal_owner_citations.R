context('List principal owner citations')
library(EDIutils)

testthat::test_that('Test for object attributes', {
  
  expect_equal(
    class(
      api_list_principal_owner_citations(
        dn = 'uid=csmith,o=LTER,dc=ecoinformatics,dc=org',
        environment = 'production'
      )
    ),
    c('xml_document', 'xml_node')
  )
  
})
