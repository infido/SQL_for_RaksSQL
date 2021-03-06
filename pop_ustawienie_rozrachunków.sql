-- modyfikacja platnosci
UPDATE R3_SP_PLATNOSCI set
WPLATA_PLN= (select (ILOSC_PO*CENA_ZAKUPU_NETTO_PO)+(ILOSC_PO*CENA_ZAKUPU_NETTO_PO*(STAWKA_ZAKUPU_PO/100)) from GM_FZ join GM_FZPOZ on GM_FZ.ID=GM_FZPOZ.ID_GLOWKI where GM_FZ.NUMER= 'FZ/2020/04/CE/0001'),
KWOTA_PLN= (select (ILOSC_PO*CENA_ZAKUPU_NETTO_PO)+(ILOSC_PO*CENA_ZAKUPU_NETTO_PO*(STAWKA_ZAKUPU_PO/100)) from GM_FZ join GM_FZPOZ on GM_FZ.ID=GM_FZPOZ.ID_GLOWKI where GM_FZ.NUMER= 'FZ/2020/04/CE/0001')
where ID_DOKUMENTU=(select ID from GM_FZ where GM_FZ.NUMER= 'FZ/2020/04/CE/0001');


-- modyfikacja samego rozrachunku
UPDATE R3_SETTLEMENT set
AMOUNT_PLN=(select (ILOSC_PO*CENA_ZAKUPU_NETTO_PO)+(ILOSC_PO*CENA_ZAKUPU_NETTO_PO*(STAWKA_ZAKUPU_PO/100)) from GM_FZ join GM_FZPOZ on GM_FZ.ID=GM_FZPOZ.ID_GLOWKI where GM_FZ.NUMER= 'FZ/2020/04/CE/0001')
where ID=(
select first 1 ID_ROZRACHUNKU 
from R3_SP_PLATNOSCI
join GM_FZ on R3_SP_PLATNOSCI.ID_DOKUMENTU=GM_FZ.ID
where GM_FZ.NUMER='FZ/2020/04/CE/0001' order by ID_ROZRACHUNKU desc)