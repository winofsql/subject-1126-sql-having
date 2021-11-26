-- 7) 得意先マスタ名を表示
SELECT
    lightbox.dbo.取引データ.取引先コード,
    max(lightbox.dbo.得意先マスタ.得意先名) AS 得意先名,
    format(sum(lightbox.dbo.取引データ.金額), '#,##0') AS 売上金額,
    count(lightbox.dbo.取引データ.取引先コード) AS 売上伝票行数,
    max(lightbox.dbo.得意先マスタ.担当者) as 担当者,
    max(lightbox.dbo.社員マスタ.氏名) as 氏名
FROM
    lightbox.dbo.取引データ
    LEFT OUTER JOIN lightbox.dbo.得意先マスタ
     ON lightbox.dbo.取引データ.取引先コード = lightbox.dbo.得意先マスタ.得意先コード
    LEFT OUTER JOIN lightbox.dbo.社員マスタ
     ON lightbox.dbo.得意先マスタ.担当者 = lightbox.dbo.社員マスタ.社員コード
GROUP BY
    lightbox.dbo.取引データ.取引先コード

HAVING
    sum(lightbox.dbo.取引データ.金額) >= 4000000
    OR
    count(lightbox.dbo.取引データ.取引先コード) >= 60

ORDER BY 
    sum(lightbox.dbo.取引データ.金額) DESC;

