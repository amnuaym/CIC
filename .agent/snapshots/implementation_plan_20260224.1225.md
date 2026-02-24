# Phase 9: UI Layout & URL Restructuring

## Proposed Changes

### 1. Pluralize Juristics URL

#### [MODIFY] [App.tsx](file:///d:/GitHub/CIC/react-admin/src/App.tsx)

- Change `<Resource name="juristic" ... />` to `<Resource name="juristics" ... />`.

#### [MODIFY] [dataProvider.ts](file:///d:/GitHub/CIC/react-admin/src/dataProvider.ts)

- Update `resourceConfig`: `juristics: { apiResource: 'customers', extraParams: { type: 'JURISTIC' } }`.
- Update `isSearchFirstResource` check to use `juristics`.
- Update `create` method type injection.

---

### 2. Fix Search Box Visibility & Top Toolbar

#### [MODIFY] [individuals.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/individuals.tsx)

#### [MODIFY] [juristic.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/juristic.tsx)

#### [MODIFY] [consents.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/consents.tsx)

- **Custom `ListActions`**: Create a shared or per-resource `TopToolbar` that renders `FilterForm`.
- **Fix Search Box**: Ensure `filters` prop is passed to both `<List>` and `<FilterForm>` for correct state synchronization.
- **Professional Empty State**: Update `EmptyList` with a dashed border, icon, and refined messaging.
- **Action buttons**: Move `CreateButton` and `ExportButton` to the `TopToolbar`.lters={filters} />
  <CreateButton />
  <ExportButton />
  </TopToolbar>
  );
  > [!NOTE]
  > Moving the search input into the `TopToolbar` ensures it's always rendered regardless of list content.

---

### 3. Redesign Empty Landing State

#### [MODIFY] [individuals.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/individuals.tsx)

#### [MODIFY] [juristic.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/juristic.tsx)

#### [MODIFY] [consents.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/consents.tsx)

Updated `EmptyList` component:

- Remove "Do you want to add one?" link.
- Use a clean, professional banner prompting for search.
- Use centered icon and simple text.

---

## Verification Plan

### Automated Tests

- `docker-compose up -d --build react-admin`

### Manual Verification

- Check URL is `/juristics`.
- Verify search bar is visible immediately on page load.
- Verify "Create" button is moved to top.
- Verify empty display is professional and lacks "add new" prompt.
