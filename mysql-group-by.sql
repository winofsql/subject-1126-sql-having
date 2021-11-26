
-- 7) 得意先マスタ名を表示
SELECT
    lightbox.取引データ.取引先コード,
    max(lightbox.得意先マスタ.得意先名) as 得意先名,
    format(sum(lightbox.取引データ.金額), 0) AS 売上金額,
    count(lightbox.取引データ.取引先コード) AS 売上伝票行数,
    max(lightbox.得意先マスタ.担当者) as 担当者,
    max(lightbox.社員マスタ.氏名) as 氏名
FROM
    lightbox.取引データ
    LEFT OUTER JOIN lightbox.得意先マスタ
     ON lightbox.取引データ.取引先コード = lightbox.得意先マスタ.得意先コード
    LEFT OUTER JOIN lightbox.社員マスタ
     ON lightbox.得意先マスタ.担当者 = lightbox.社員マスタ.社員コード
GROUP BY
    lightbox.取引データ.取引先コード

HAVING
    sum(lightbox.取引データ.金額) >= 4000000
    OR
    売上伝票行数 >= 60

ORDER BY 
    sum(lightbox.取引データ.金額) DESC;

