use portfolio;
-- Standardize Date Format

ALTER TABLE NashvilleHousing ADD SaleDateConverted DATE;

UPDATE NashvilleHousing
SET SaleDateConverted = STR_TO_DATE(SaleDate, '%M %e, %Y');

SELECT SaleDate, SaleDateConverted
FROM NashvilleHousing
LIMIT 10;

-- Populate property Address data

select a.parcelid,a.propertyaddress,b.parcelid,b.propertyaddress, IFNULL(a.propertyaddress,b.propertyaddress)
from nashvillehousing a join nashvillehousing b on a.parcelid=b.parcelid
AND a.uniqueId<>b.uniqueid 
where b.propertyaddress is NULL;  

SET SQL_SAFE_UPDATES = 0;

UPDATE NashvilleHousing a
JOIN NashvilleHousing b 
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = b.PropertyAddress
WHERE a.PropertyAddress IS NULL;

UPDATE NashvilleHousing a
JOIN NashvilleHousing b 
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = b.PropertyAddress
WHERE b.PropertyAddress IS NULL;

-- Breaking out Address in Individual Coloumns (Address , city, state)

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress TEXT;

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1);

ALTER TABLE NashvilleHousing
ADD PropertySplitCity TEXT;

UPDATE NashvilleHousing
SET PropertySplitCity = TRIM(SUBSTRING_INDEX(PropertyAddress, ',', -1)); 
  
Select * from NashvilleHousing limit 10;

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress TEXT,
ADD OwnerSplitCity TEXT,
ADD OwnerSplitState TEXT;

UPDATE NashvilleHousing
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);

UPDATE NashvilleHousing
SET OwnerSplitCity = TRIM(
    SUBSTRING_INDEX(
        SUBSTRING_INDEX(OwnerAddress, ',', 2),
        ',',
        -1
    )
);

UPDATE nashvilleHousing
set ownersplitstate = substring_index(owneraddress,',',-1);

Select * from NashvilleHousing limit 10; 

-- Change Y to Yes and N to  NO in "Sold as Vacant" field

select distinct SoldAsVacant, count(SoldAsVacant) from NashvilleHousing 
group by SoldAsVacant
order by 2;

SELECT 
    SoldAsVacant,
    CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END AS CleanedValue
FROM NashvilleHousing;

UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END;

SELECT SoldAsVacant, COUNT(*)
FROM NashvilleHousing
GROUP BY SoldAsVacant;

-- Remove Duplicates

WITH RowNumCTE AS (
    SELECT UniqueID,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM NashvilleHousing
)
DELETE FROM NashvilleHousing
WHERE UniqueID IN (
    SELECT UniqueID
    FROM RowNumCTE
    WHERE row_num > 1
); 

-- Delete Unused Coloumns
 

Alter table NashvilleHousing 
	drop column Owneraddress ,
	drop column TaxDistrict, 
	drop column PropertyAddress ; 
    
Alter table NashvilleHousing 
	drop column SaleDate;

    