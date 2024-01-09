/*
cleaning DAta in SQL Queries

*/

Select *
FROM portifolioo.dbo.[nashville Housing]

--standardize Date Format

Select saleDateConverted, CONVERT(Date,SaleDate)
FROM portifolioo.dbo.[nashville Housing]

Update [nashville Housing]
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE [nashville Housing]
Add SaleDateConverted Date;

Update [nashville Housing]
SET SaleDateConverted = CONVERT(Date,SaleDate)





--populate property adress data


Select *
FROM portifolioo.dbo.[nashville Housing]
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyAddress,b.PropertyAddress)
FROM portifolioo.dbo.[nashville Housing] a
JOIN portifolioo.dbo.[nashville Housing] b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID ]<> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET propertyAddress = ISNULL(a.propertyAddress,b.PropertyAddress)
FROM portifolioo.dbo.[nashville Housing] a
JOIN portifolioo.dbo.[nas hville Housing] b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID ]<> b.[UniqueID ]
Where a.PropertyAddress is null



--Breaking out Adress into individuals columns (Address, City, State)

Select PropertyAddress
FROM portifolioo.dbo.[nashville Housing]
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(propertyAddress, 1, CHARINDEX(',', propertyAddress) -1) as Address
, SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress) +1 , LEN(propertyAddress)) as Address

FROM portifolioo.dbo.[nashville Housing]

ALTER TABLE [nashville Housing]
Add propertySplitAddress Nvarchar(255);

Update [nashville Housing]
SET propertySplitAddress = SUBSTRING(propertyAddress, 1, CHARINDEX(',', propertyAddress) -1) 

ALTER TABLE [nashville Housing]
Add propertySplitCity Nvarchar(255);

Update [nashville Housing]
SET propertySplitCity = SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress) +1 , LEN(propertyAddress)) 


Select*

FROM portifolioo.dbo.[nashville Housing]





Select OwnerAddress
FROM portifolioo.dbo.[nashville Housing]


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
 ,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
 ,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM portifolioo.dbo.[nashville Housing]


ALTER TABLE [nashville Housing]
Add OwnerSpliticity Nvarchar(255);

Update [nashville Housing]
SET PropertySplitAddress =PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE [nashville Housing]
Add OwnerSplitCity Nvarchar(255);

Update [nashville Housing]
SET OwnerSpliticity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)



ALTER TABLE [nashville Housing]
Add OwnerSplitState Nvarchar(255);

Update [nashville Housing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) 


Select *
From portifolioo.dbo.[nashville Housing]


--change y and n to yes and no in"Sold as Vacant"field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From portifolioo.dbo.[nashville Housing]
Group by SoldAsVacant
order by 2



Select SoldAsVacant
, CASE When SoldAsVacant = 'y' THEN 'yes'
	   When SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
From portifolioo.dbo.[nashville Housing]

Update [nashville Housing]
SET SoldAsVacant = CASE When SoldAsVacant = 'y' THEN 'yes'
	   When SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END



---Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 propertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				  UniqueID
				  ) row_num

From portifolioo.dbo.[nashville Housing]
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num>1
order by PropertyAddress

Select*
From portifolioo.dbo.[nashville Housing]





--Delete unused Columns


Select*
From portifolioo.dbo.[nashville Housing]

ALTER TABLE portifolioo.dbo.[nashville Housing]
DROP COLUMN OwnerAddress, TaxDIstrict, PropertyAddress


ALTER TABLE portifolioo.dbo.[nashville Housing]
DROP COLUMN SaleDate






