import { useState } from 'react';
import { useInput, InputProps } from 'react-admin';
import { TextField, InputAdornment, IconButton } from '@mui/material';
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';

interface PasswordInputProps extends Omit<InputProps, 'source'> {
  source: string;
  label?: string;
  required?: boolean;
  fullWidth?: boolean;
}

const PasswordInput = ({ source, label, required, fullWidth = true, ...rest }: PasswordInputProps) => {
  const [showPassword, setShowPassword] = useState(false);
  const { field, fieldState } = useInput({ source, ...rest });

  return (
    <TextField
      {...field}
      label={label || source}
      type={showPassword ? 'text' : 'password'}
      required={required}
      fullWidth={fullWidth}
      error={!!fieldState.error}
      helperText={fieldState.error?.message}
      margin="dense"
      InputProps={{
        endAdornment: (
          <InputAdornment position="end">
            <IconButton
              aria-label="toggle password visibility"
              onClick={() => setShowPassword(!showPassword)}
              edge="end"
              size="small"
            >
              {showPassword ? <VisibilityOff /> : <Visibility />}
            </IconButton>
          </InputAdornment>
        ),
      }}
    />
  );
};

export default PasswordInput;
