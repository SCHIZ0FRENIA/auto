BEGIN
  CTX_DDL.CREATE_PREFERENCE('cars_lexer', 'BASIC_LEXER');
END;

CREATE OR REPLACE PROCEDURE search_cars (
    p_search_term IN VARCHAR2,
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
    SELECT *
    FROM cars
    WHERE CONTAINS(search_text, p_search_term) > 0;
END;

CREATE INDEX cars_search_idx ON cars (search_text) INDEXTYPE IS CTXSYS.CONTEXT;