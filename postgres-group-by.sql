-- 7) 得意先マスタ名を表示
SELECT
    lightbox.public.取引データ.取引先コード,
    max(lightbox.public.得意先マスタ.得意先名) AS 得意先名,
    to_char(sum(lightbox.public.取引データ.金額), 'fm999,999,999') AS 売上金額,
    count(lightbox.public.取引データ.取引先コード) AS 売上伝票行数,
    max(lightbox.public.得意先マスタ.担当者) as 担当者,
    max(lightbox.public.社員マスタ.氏名) as 氏名
FROM
    lightbox.public.取引データ
    LEFT OUTER JOIN lightbox.public.得意先マスタ
     ON lightbox.public.取引データ.取引先コード = lightbox.public.得意先マスタ.得意先コード
    LEFT OUTER JOIN lightbox.public.社員マスタ
     ON lightbox.public.得意先マスタ.担当者 = lightbox.public.社員マスタ.社員コード
GROUP BY
    lightbox.public.取引データ.取引先コード

HAVING
    sum(lightbox.public.取引データ.金額) >= 4000000
    OR
    count(lightbox.public.取引データ.取引先コード) >= 60

ORDER BY 
    sum(lightbox.public.取引データ.金額) DESC;


