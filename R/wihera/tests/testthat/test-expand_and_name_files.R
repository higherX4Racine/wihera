test_that("using every result gives full, named paths", {
    .TEST_PATH <- "foo/bar/baz"
    .FILES <- c(alpha = "aleph", beta = "bab", gamma = "jeen")
    .LABELS <- c("A", "B", "C")
    expect_equal(
        expand_and_name_files(.FILES,
                              .TEST_PATH,
                              .LABELS),
        c(A = "foo/bar/baz/aleph",
          B = "foo/bar/baz/bab",
          C = "foo/bar/baz/jeen")
    )
    expect_equal(
        expand_and_name_files(.LABELS,
                              .TEST_PATH,
                              .FILES),
        c(aleph = "foo/bar/baz/A",
          bab = "foo/bar/baz/B",
          jeen = "foo/bar/baz/C")
    )
})

test_that("omitting labels gives full paths named with base- or vector names", {
    .TEST_PATH <- "foo/bar/baz"
    .FILES <- c("barf/aleph", "bab", "jeen")
    expect_equal(
        expand_and_name_files(.FILES,
                              .TEST_PATH),
        c(aleph = "foo/bar/baz/barf/aleph",
          bab = "foo/bar/baz/bab",
          jeen = "foo/bar/baz/jeen")
    )
    expect_equal(
        expand_and_name_files(rlang::set_names(.FILES, c("a", "b", "c")),
                              .TEST_PATH),
        c(a = "foo/bar/baz/barf/aleph",
          b = "foo/bar/baz/bab",
          c = "foo/bar/baz/jeen")
    )
})

test_that("omitting the path gives paths named with base- or vector names", {
    .TEST_PATH <- ""
    .FILES <- c("foo/bar/baz/barf/aleph", "foo/bar/baz/bab", "foo/bar/jeen")
    expect_equal(
        expand_and_name_files(.FILES),
        c(aleph = "foo/bar/baz/barf/aleph",
          bab = "foo/bar/baz/bab",
          jeen = "foo/bar/jeen")
    )
    expect_equal(
        expand_and_name_files(.FILES,
                              .labels = c("a", "b", "c")),
        c(a = "foo/bar/baz/barf/aleph",
          b = "foo/bar/baz/bab",
          c = "foo/bar/jeen")
    )
})
