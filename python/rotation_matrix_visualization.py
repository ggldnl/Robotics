import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.widgets import Slider


def get_rotation_matrix(theta):
    """
    return np.array([
        [np.cos(theta), -np.sin(theta), 0],
        [np.sin(theta), np.cos(theta), 0],
        [0, 0, 1]
    ])
    """

    return np.array([
        [np.cos(theta), 0, np.sin(theta)],
        [np.sin(theta), 0, -np.cos(theta)],
        [0, 1, 0]
    ])

def plot_frame(ax, origin, R, label_suffix):
    """
    Plot a 3D frame with colored axes and labels.
    """
    
    x_axis = R[:, 0]
    y_axis = R[:, 1]
    z_axis = R[:, 2]

    ax.quiver(*origin, *x_axis, color='r', length=1, normalize=True, capstyle='round')
    ax.quiver(*origin, *y_axis, color='g', length=1, normalize=True, capstyle='round')
    ax.quiver(*origin, *z_axis, color='b', length=1, normalize=True, capstyle='round')

    ax.text(*(origin + x_axis), f'x{label_suffix}', color='r')
    ax.text(*(origin + y_axis), f'y{label_suffix}', color='g')
    ax.text(*(origin + z_axis), f'z{label_suffix}', color='b')

def update(var):

    theta = slider.val
    R = get_rotation_matrix(theta)

    ax.cla()
    plot_frame(ax, np.array([0, 0, 0]), np.eye(3), '0')
    plot_frame(ax, np.array([0, 0, 0]), R, '1')

    ax.set_xlim([-1, 1])
    ax.set_ylim([-1, 1])
    ax.set_zlim([-1, 1])

    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')

    plt.draw()

# Set up the plot
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Plot initial frames
plot_frame(ax, np.array([0, 0, 0]), np.eye(3), '0')
plot_frame(ax, np.array([0, 0, 0]), np.eye(3), '1')

# Set the plot limits
ax.set_xlim([-1, 1])
ax.set_ylim([-1, 1])
ax.set_zlim([-1, 1])

# Set the labels
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# Add a slider for the rotation angle
ax_slider = plt.axes([0.1, 0.1, 0.5, 0.05])
slider = Slider(ax_slider, 'Angle', 0, 2 * np.pi, valinit=0)
slider.on_changed(update)

plt.show()
