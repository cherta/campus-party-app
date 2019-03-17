import React from "react";
import { withStyles } from "@material-ui/core";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import Typography from "@material-ui/core/Typography";
import IconButton from "@material-ui/core/IconButton";
import HomeIcon from "@material-ui/icons/Home";

const styles = {
  grow: {
    flexGrow: 1
  },
  menuButton: {
    marginLeft: -12,
    marginRight: 20
  }
};

const Header = ({ classes }) => (
  <AppBar position="fixed">
    <Toolbar>
      <IconButton className={classes.menuButton} color="inherit" aria-label="Menu">
        <HomeIcon />
      </IconButton>
      <Typography variant="h6" color="inherit" className={classes.grow}>
        Campus Talks
      </Typography>
    </Toolbar>
  </AppBar>
);

export default withStyles(styles)(Header);
