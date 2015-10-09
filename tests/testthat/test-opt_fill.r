library(magrittr)

context('opt_fill')


proto <- list( foo="foo", bar=0 )
   
# No opts
res <- opt_fill( proto, opts=c() )
res$foo %>% expect_equal("foo")
res$bar %>% expect_equal(0)

# One opt
res <- opt_fill( proto, opts=c( '--foo', 'ok' ))
res$foo %>% expect_equal('ok')
res$bar %>% expect_equal(0)

# Two opts
res <- opt_fill( proto, opts=c( '--foo', 'ok', '--bar', '1' ))
res$foo %>% expect_equal('ok')
res$bar %>% expect_equal(1)



# Reference structures

proto_env <- as.environment(proto)


opt_fill( proto_env, opts=c( '--foo', 'ok' ))
proto_env$foo %>% expect_equal('ok')   
proto_env$bar %>% expect_equal(0)

opt_fill( proto_env,  opts=c( '--foo', 'ok', '--bar', '1' ) )
proto_env$foo %>% expect_equal('ok')
proto_env$bar %>% expect_equal(1)
